class Leads {
  String leadID;
  String name;
  String emailID;
  String phoneNumber;
  String instructions;
  String status;
  String secNumber;
  String rawDescription;
  String createdDate;
  String updatedDate;
  Leads(
      {required this.emailID,
      required this.leadID,
      required this.name,
      required this.phoneNumber,
      required this.status,
      required this.instructions,
      required this.secNumber,
      required this.rawDescription,
      required this.createdDate,
      required this.updatedDate});
}
