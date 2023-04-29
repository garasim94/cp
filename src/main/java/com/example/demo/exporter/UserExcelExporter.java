package com.example.demo.exporter;

import com.example.demo.domain.User;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserExcelExporter {
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    private List<User> userList;

    private void writeHeaderRow(){
        Row row= sheet.createRow(0);

        Cell cell= row.createCell(0);
        cell.setCellValue("User id");
        cell= row.createCell(1);
        cell.setCellValue("Username");
        cell= row.createCell(2);
        cell.setCellValue("Is active");
        cell= row.createCell(3);
        cell.setCellValue("Roles");
    }

    private void writeDataRows(){
        int rowCount =1;
        for(User user: userList){
            Row row= sheet.createRow(rowCount);
            Cell cell= row.createCell(0);
            cell.setCellValue(user.getId());

            cell= row.createCell(1);
            cell.setCellValue(user.getUsername());

            cell= row.createCell(2);
            cell.setCellValue(user.isActive());

            cell= row.createCell(3);
            cell.setCellValue(user.getRolesString());
            rowCount++;
        }
    }

    public void export(HttpServletResponse response) throws IOException {
        writeHeaderRow();
        writeDataRows();

        for (int i = 0; i < 4; i++) {
            sheet.autoSizeColumn(i);
        }

        ServletOutputStream outputStream= response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

    public UserExcelExporter(List<User> userList) {
        this.userList = userList;
        workbook= new XSSFWorkbook();
        sheet= workbook.createSheet("User");
    }
}
