module Admin
  module ImportProductsHelper
    def open_spreadsheet file
      return unless file
      case File.extname(file.original_filename)
      when ".csv"
        Roo::CSV.new(file.path, file_warning: :ignore)
      when ".xls"
        Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx"
        Roo::Excelx.new(file.path, file_warning: :ignore)
      end
    end
  end
end
