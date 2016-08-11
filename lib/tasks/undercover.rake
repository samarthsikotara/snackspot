namespace :undercover do
  task :changed_date_for_csv => :environment do
    file = "#{Rails.root}/public/all_status_v2.csv"
    CSV.open( file, 'w' ) do |writer|
      writer << ["Depot", "Parcel_ID", "Primary_Sort_Code", "Encoded_Date", "Tour_Created_Date", "Tour_Closed_Date", "Delivered_Event", "Tour_Debriefef", "Tour_ID", "Driver_IR", "Tour_Status", "Expected_CoD", "Actual_CoD", "Delievered_CoD", "Status", "Tour_Created_Date"]
      CSV.foreach("#{Rails.root}/public/all_status.csv",{:headers=>:first_row}) do |row|
        unless row["Tour_Created_Date"].nil?
          whole_date = row["Tour_Created_Date"].split(".")
          year = whole_date[2].split(" ")[0];month = whole_date[1];day = whole_date[0];time = whole_date[2].split(" ")[1]
          date_format = "#{year}"+"-"+"#{month}"+"-"+"#{day}"+" "+"#{time}"      
        else
          date_format = ""
        end
        unless row["Tour_Closed_Date"].nil?
          whole_date = row["Tour_Closed_Date"].split(".")
          year = whole_date[2].split(" ")[0];month = whole_date[1];day = whole_date[0];time = whole_date[2].split(" ")[1]
          date_format_1 = "#{year}"+"-"+"#{month}"+"-"+"#{day}"+" "+"#{time}"      
        else
          date_format_1 = ""
        end
        unless row["Delivered_Event"].nil?
          whole_date = row["Delivered_Event"].split(".")
          year = whole_date[2].split(" ")[0];month = whole_date[1];day = whole_date[0];time = whole_date[2].split(" ")[1]
          date_format_2 = "#{year}"+"-"+"#{month}"+"-"+"#{day}"+" "+"#{time}"      
        else
          date_format_2 = ""
        end
        unless row["Tour_Debriefef"].nil?
          whole_date = row["Tour_Debriefef"].split(".")
          year = whole_date[2].split(" ")[0];month = whole_date[1];day = whole_date[0];time = whole_date[2].split(" ")[1]
          date_format_3 = "#{year}"+"-"+"#{month}"+"-"+"#{day}"+" "+"#{time}"      
        else
          date_format_3 = ""
        end
        p "time changed for #{row[1]} - #{date_format} - #{date_format_1} - #{date_format_2} - #{date_format_3}"
        writer << [row[0], row[1], row[2], row[3], date_format, date_format_1, date_format_2, date_format_3, row[8], row[9], row[10], row[11], row[12], row[13], row[14], row[15]]
      end
    end
  end
end