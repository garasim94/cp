package com.example.demo.exporter;

import com.example.demo.domain.Train;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TrainExcelExporter {
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    private List<Train> trainList;

    private void writeHeaderRow(){
        Row row= sheet.createRow(0);

        Cell cell= row.createCell(0);
        cell.setCellValue("Train id");
        cell= row.createCell(1);
        cell.setCellValue("Train Number");
        cell= row.createCell(2);
        cell.setCellValue("Train Name");
    }

    private void writeDataRows(){
        int rowCount =1;
        for(Train train: trainList){
            Row row= sheet.createRow(rowCount);
            Cell cell= row.createCell(0);
            cell.setCellValue(train.getId());

            cell= row.createCell(1);
            cell.setCellValue(train.getTrainNumber());

            cell= row.createCell(2);
            cell.setCellValue(train.getTrainName());
            rowCount++;
        }
    }

    public void export(HttpServletResponse response) throws IOException {
        writeHeaderRow();
        writeDataRows();

        ServletOutputStream outputStream= response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

    public TrainExcelExporter(List<Train> trainList) {
        this.trainList = trainList;
        workbook= new XSSFWorkbook();
        sheet= workbook.createSheet("Trains");
    }
}
