class FightReportCard < ActiveRecord::Base

  enum_attr :status, :in => [
    ['unstart', 0, '未开始'],
    ['started', 1, '已开始'],
    ['registered', 2, '已注册']
  ]

  enum_attr :win_status, :in => [
    ['unwin', 0, '未中奖'],
    ['wined', 1, '已中奖'],
    ['drawed', 2, '已领奖']
  ]

  belongs_to :activity_user
  belongs_to :activity_prize
  belongs_to :activity_consume
  belongs_to :user

  after_initialize  :set_defaults, if: :new_record?

  def self.export_excel(search)
    xls_report = StringIO.new
    book = FightReportCard.new_excel
    book_excel = book[0]
    book_sheet = book[1]
    export_title = ['排名', '昵称', '手机号码', '积分', '用时', 'SN码', '状态']
    sing_sheet = []
    sing_sheet << export_title

    search.to_a.each_with_index do |s,i|
      sing_sheet << [(i+1), s.activity_user.try(:name), s.activity_user.try(:mobile), s.score, s.speed, s.activity_consume.try(:code), s.activity_consume.try(:status_name)].flatten
    end
    sing_sheet.each_with_index do |new_sheet,index|
      book_sheet.insert_row(index,new_sheet)
    end
    book_excel.write(xls_report)
    return xls_report.string
  end

  def self.new_excel
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    bold_heading = Spreadsheet::Format.new(:weight => :bold, :align => :merge)
    sheet = book.create_worksheet :name => "活动数据"
    return [book,sheet,bold_heading]
  end


  #activity_user_id maybe nil, when create FightReportCard, ex. fight
  def set_defaults
     self.activity_user_id ||= 0
  end
end
