Attribute VB_Name = "Module1"
Sub Calculation()


For Each ws In Worksheets
Dim WorksheetName As String

lastRow = Cells(Rows.Count, 1).End(xlUp).Row

WorksheetsName = ws.Name

'Pull the closing price and total volume

'Set the Headers and Adjust the column Width
ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"
ws.Range("I:L").EntireColumn.AutoFit
ws.Range("N1").Value = "OpenPrice"
ws.Range("O1").Value = "ClosePrice"

Dim Ticker As String
Dim OpPrice As Double
Dim ClPrice As Double
Dim PercentChange As Double
Dim TotalVol As Double
TotalVol = 0

Dim Summary_Table_Row As Integer
Summary_Table_Row = 2


    For I = 2 To lastRow

    If ws.Cells(I + 1, 1).Value <> ws.Cells(I, 1).Value Then

    ' Capture the 1st set of information
    Ticker = ws.Cells(I, 1).Value
    ClPrice = ws.Cells(I, 6).Value
    TotalVol = TotalVol + ws.Cells(I, 7).Value


    ' Populate the 1st set of information in the Summar Table
    ws.Range("I" & Summary_Table_Row).Value = Ticker
    ws.Range("O" & Summary_Table_Row).Value = ClPrice
    ws.Range("L" & Summary_Table_Row).Value = TotalVol

    Summary_Table_Row = Summary_Table_Row + 1
    
    'Reset the Totals
    TotalVol = 0
        Else

    TotalVol = TotalVol + Cells(I, 7).Value
   
    End If

    Next I
    
    
'Re-sort the worksheets in Descending Date Order

Dim ActiveSelection As Range
Set ActiveSelection = Range("A1", Range("G1").End(xlDown))
    
    Range("A1", Range("G1").End(xlDown)).Select
    'ActiveWorkbook.ws.sort.SortFields.Clear
    ws.sort.SortFields.Clear

    With ws.sort
    .SortFields.Add Key:=Range("A1"), Order:=xlAscending
    .SortFields.Add Key:=Range("B1"), Order:=xlDescending
    .SetRange ActiveSelection
    .Header = xlYes
    .Apply
    End With
    
    
'Pull the opening price

lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row

Summary_Table_Row = 2
    
   
    For I = 2 To lastRow

        If ws.Cells(I + 1, 1).Value <> ws.Cells(I, 1).Value Then

    Ticker = ws.Cells(I, 1).Value
    OpPrice = ws.Cells(I, 3).Value

    ' Print the Data 2nd set in the Summary Table
    ws.Range("N" & Summary_Table_Row).Value = OpPrice
    Summary_Table_Row = Summary_Table_Row + 1
   
        End If

    Next I

'Calculate Variance between open price at the beginning of the year and he close price at the end of the year

Dim Yearly_Change As Double
Summary_Table_Row = 2

lastRow = ws.Cells(Rows.Count, 14).End(xlUp).Row

    For I = 2 To lastRow

    OpPrice = ws.Cells(I, 14).Value
    ClPrice = ws.Cells(I, 15).Value


    ws.Range("J" & Summary_Table_Row).Value = ClPrice - OpPrice
    ws.Cells(I, 11).NumberFormat = "0.00%"
        If OpPrice <> 0 Then
        ws.Range("K" & Summary_Table_Row).Value = (ClPrice - OpPrice) / OpPrice
        'ws.Range("K" & Summary_Table_Row).Value = Round(((ClPrice - OpPrice) / OpPrice * 100), 2)
        Else
        ws.Range("K" & Summary_Table_Row).Value = 0
        End If

    Summary_Table_Row = Summary_Table_Row + 1

    Next I

'Format the color of the cells

    Dim j As Long, r1 As Range

    lastRow = ws.Cells(Rows.Count, 10).End(xlUp).Row

    For j = 2 To lastRow

    Set r1 = ws.Cells(j, 10)
    
    If r1 < 0 Then r1.Interior.Color = vbRed
    If r1 >= 0 Then r1.Interior.Color = vbGreen
    
    Next j

Next ws
  
    For Each ws2 In Worksheets
    Dim WorksheetSName2 As String

    WorksheetName2 = ws2.Name
    Sheets(WorksheetName2).Select
    Range("N:O").EntireColumn.Delete

    Next ws2
    
    For Each ws3 In Worksheets
    Dim WorksheetName3 As String

    WorksheetsName3 = ws3.Name
    Sheets(WorksheetsName3).Select
 
    lastRow = ws3.Cells(Rows.Count, 11).End(xlUp).Row

     ws3.Range("P1") = "Ticker"
     ws3.Range("Q1") = "Value"
     ws3.Range("O2").Value = "Gretest % Increase"
     ws3.Range("O3").Value = "Gretest % Decrease"
     ws3.Range("O4").Value = "Gretest Total Volume"
     For Each cell In ws3.Range("K2:K" & lastRow)
           If high < cell.Value Then
               high = cell.Value
               rowHigh = cell.Row()
           End If
           If low > cell.Value Then
               low = cell.Value
               rowLow = cell.Row()
           End If
        Next cell
        ws3.Range("P2").Value = ws3.Range("I" & rowHigh).Value
        ws3.Range("R2").Value = high
        ws3.Range("P3").Value = ws3.Range("I" & rowLow).Value
        ws3.Range("R3").Value = low
       For Each cell In ws3.Range("L2:L" & lastRow)
           If hVolume < cell.Value Then
               hVolume = cell.Value
               hVRow = cell.Row()
           End If
       Next cell
       ws3.Range("P4").Value = ws3.Range("I" & hVRow).Value
       ws3.Range("Q4").Value = hVolume
       high = 0
       rowHigh = 0
       low = 0
       rowLow = 0
       hVolume = 0
       hVRow = 0
       lRow = 0
        
              
       ws3.Range("Q2").Value = (Range("R2") * 100) & "%"
       ws3.Range("Q3").Value = (Range("R3") * 100) & "%"
       ws3.Range("O:Q").EntireColumn.AutoFit
       Sheets(WorksheetsName3).Select
       Range("R:R").EntireColumn.Delete
 Next ws3

End Sub
