import os
import csv


cwd = os.getcwd()
budget_path=os.path.join('C:/Users/pasqu/OneDrive/Documents/UT-TOR-DATA-PT-09-2019-U-C/Unit 3 - Python/Homework/Instructions/PyBank/Resources/budget_data.csv')
#budget_path=os.path.join("Resources","budget_data.csv")
print (cwd)



months = 0
net_profit = max_incr_change = max_decr_change = avg_change = previous =0
change = init_change = end_change = 0.0
with open(budget_path, 'r') as csvfile:
    csv_reader = csv.reader(csvfile, delimiter = ",")
    next (csv_reader)

    for row in csv_reader:
        months += 1
        net_profit = net_profit + int(row[1])
        if previous == 0:
            init_change= int(row[1])
        change = int(row[1]) - previous

        if change > max_incr_change:
            max_incr_change = change
            max_profit_index = row[0]
            
        if change < max_decr_change:
            max_decr_change = change
            max_loss_index = row[0]
            
        previous = int(row[1])
        end_change += change
        
    avg_change = (end_change - init_change)/(months-1)

    print(f"Total Months: {months}")
    print(f"Total: $ {net_profit}")
    print(f"Average Change: $ {avg_change}")
    print(f"Greatest Increase in Profits: {max_profit_index} ($ {max_incr_change})")
    print(f"Greatest Decrease in Profits: {max_loss_index} ($ {max_decr_change})")

    
   #Specify the file to write to
output_path=os.path.join('C:/Users/pasqu/OneDrive/Documents/UT-TOR-DATA-PT-09-2019-U-C/Unit 3 - Python/Homework/Instructions/PyBank/Resources/budget_output.csv')
#output_path = os.path.join('Resources', 'budget_output.csv')
# Open the file using "write" mode. Specify the variable to hold the contents
with open(output_path, 'w', newline='') as csvfile2:
    #Initialize csv.writer
    csvwriter = csv.writer(csvfile2, delimiter=',')
    # Write the row content
    csvwriter.writerow(['Total Months:', months])
    csvwriter.writerow(['Total $:', net_profit])
    csvwriter.writerow(['Averge Change $:', avg_change])
    csvwriter.writerow(['Greatest Increase in Profits:', max_profit_index, max_incr_change])
    csvwriter.writerow(['Greatest Decrease in Profits:', max_loss_index, max_decr_change])
   
