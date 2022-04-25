class Leads {
  String leadID;
  String name;
  String emailID;
  int phoneNumber;
  String instructions;
  String description;
  String status;
  Leads(
      {required this.emailID,
      required this.leadID,
      required this.name,
      required this.phoneNumber,
      required this.status,
      required this.description,
      required this.instructions});
}
