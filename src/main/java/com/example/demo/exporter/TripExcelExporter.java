package com.example.demo.exporter;

import com.example.demo.domain.Trip;
import com.example.demo.domain.User;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class TripExcelExporter {
    private XSSFWorkbook workbook;
    private XSSFSheet sheet;

    private List<Trip> tripList;

    private void writeHeaderRow(){
        Row row= sheet.createRow(0);

        Cell cell= row.createCell(0);
        cell.setCellValue("Trip id");
        cell= row.createCell(1);
        cell.setCellValue("Route number");
        cell= row.createCell(2);
        cell.setCellValue("Departure date");
        cell= row.createCell(3);
        cell.setCellValue("Arrival date");
        cell= row.createCell(4);
        cell.setCellValue("Departure time");
        cell= row.createCell(5);
        cell.setCellValue("Arrival time");
        cell= row.createCell(6);
        cell.setCellValue("Point of departure");
        cell= row.createCell(7);
        cell.setCellValue("Point of arrival");
        cell= row.createCell(8);
        cell.setCellValue("Driver");
        cell= row.createCell(9);
        cell.setCellValue("Train");
    }

    private void writeDataRows(){
        int rowCount =1;
        for(Trip trip: tripList){
            Row row= sheet.createRow(rowCount);
            Cell cell= row.createCell(0);
            cell.setCellValue(trip.getId());

            cell= row.createCell(1);
            cell.setCellValue(trip.getRouteNumber());

            cell= row.createCell(2);
            cell.setCellValue(trip.getDepartureDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));

            cell= row.createCell(3);
            cell.setCellValue(trip.getArrivalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));

            cell= row.createCell(4);
            cell.setCellValue(trip.getDepartureTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            cell= row.createCell(5);
            cell.setCellValue(trip.getArrivalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            cell= row.createCell(6);
            cell.setCellValue(trip.getStartPoint());

            cell= row.createCell(7);
            cell.setCellValue(trip.getEndPoint());

            cell= row.createCell(8);
            cell.setCellValue(trip.getDriver().getUsername());

            cell= row.createCell(9);
            cell.setCellValue(trip.getTrainTrips().getTrain().getTrainName());

            rowCount++;
        }
    }

    public void export(HttpServletResponse response) throws IOException {
        writeHeaderRow();
        writeDataRows();

        for (int i = 0; i < 10; i++) {
            sheet.autoSizeColumn(i);
        }

        ServletOutputStream outputStream= response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.close();
    }

    public TripExcelExporter(List<Trip> tripList) {
        this.tripList = tripList;
        workbook= new XSSFWorkbook();
        sheet= workbook.createSheet("Trips");
    }
}
