class Question {
  const Question(
    this.id,
    this.linhVucId,
    this.cauHoi,
    this.dapAn1,
    this.dapAn2,
    this.dapAn3,
    this.dapAn4,
    this.dapAnDung,
  );
  //Định danh
  final int id;
  //Nối với id lĩnh vực
  final int linhVucId;
  //Dữ liệu câu hỏi
  final String cauHoi;
  final String dapAn1;
  final String dapAn2;
  final String dapAn3;
  final String dapAn4;
  //Phương án đúng
  //0 == chọn A
  //1 == chọn B
  //2 == chọn C
  //3 == chọn C
  final int dapAnDung;
}
