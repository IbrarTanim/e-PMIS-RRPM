import 'dart:convert';

WorkflowExpenditureDetailsResponse workflowExpenditureDetailsResponseFromJson(String str) => WorkflowExpenditureDetailsResponse.fromJson(json.decode(str));

String workflowExpenditureDetailsResponseToJson(WorkflowExpenditureDetailsResponse data) => json.encode(data.toJson());

class WorkflowExpenditureDetailsResponse {
  String? projectExpenditureId;
  String? voucherNo;
  String? fiscalYearsId;
  String? projectId;
  String? projectOfficeId;
  String? projectOfficeName;
  dynamic projectProformaLocationMasterId;
  dynamic locationName;
  String? projectProformaProcurementId;
  String? packageNo;
  String? packageDescription;
  String? projectProcurementActualId;
  String? projectProcurementActualContractId;
  DateTime? voucherDate;
  dynamic projectExpenditureFileId;
  int? expenditureAmount;
  String? projectBankInformationId;
  String? bankName;
  String? accountNo;
  String? accountName;
  String? chequeNo;
  DateTime? paymentDate;
  String? baseModeOfPayment;
  String? remarks;
  int? vatAmount;
  int? aitAmount;
  String? taxOfficeId;
  String? taxOfficeName;
  String? paymentPurpose;

  WorkflowExpenditureDetailsResponse({
    this.projectExpenditureId,
    this.voucherNo,
    this.fiscalYearsId,
    this.projectId,
    this.projectOfficeId,
    this.projectOfficeName,
    this.projectProformaLocationMasterId,
    this.locationName,
    this.projectProformaProcurementId,
    this.packageNo,
    this.packageDescription,
    this.projectProcurementActualId,
    this.projectProcurementActualContractId,
    this.voucherDate,
    this.projectExpenditureFileId,
    this.expenditureAmount,
    this.projectBankInformationId,
    this.bankName,
    this.accountNo,
    this.accountName,
    this.chequeNo,
    this.paymentDate,
    this.baseModeOfPayment,
    this.remarks,
    this.vatAmount,
    this.aitAmount,
    this.taxOfficeId,
    this.taxOfficeName,
    this.paymentPurpose,
  });

  factory WorkflowExpenditureDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowExpenditureDetailsResponse(
    projectExpenditureId: json["project_expenditure_id"],
    voucherNo: json["voucher_no"],
    fiscalYearsId: json["fiscal_years_id"],
    projectId: json["project_id"],
    projectOfficeId: json["project_office_id"],
    projectOfficeName: json["project_office_name"],
    projectProformaLocationMasterId: json["project_proforma_location_master_id"],
    locationName: json["location_name"],
    projectProformaProcurementId: json["project_proforma_procurement_id"],
    packageNo: json["package_no"],
    packageDescription: json["package_description"],
    projectProcurementActualId: json["project_procurement_actual_id"],
    projectProcurementActualContractId: json["project_procurement_actual_contract_id"],
    voucherDate: json["voucher_date"] == null ? null : DateTime.parse(json["voucher_date"]),
    projectExpenditureFileId: json["project_expenditure_file_id"],
    expenditureAmount: json["expenditure_amount"]?.round(),
    projectBankInformationId: json["project_bank_information_id"],
    bankName: json["bank_name"],
    accountNo: json["account_no"],
    accountName: json["account_name"],
    chequeNo: json["cheque_no"],
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    baseModeOfPayment: json["base_mode_of_payment"],
    remarks: json["remarks"],
    vatAmount: json["vat_amount"]?.round(),
    aitAmount: json["ait_amount"]?.round(),
    taxOfficeId: json["tax_office_id"],
    taxOfficeName: json["tax_office_name"],
    paymentPurpose: json["payment_purpose"],
  );

  Map<String, dynamic> toJson() => {
    "project_expenditure_id": projectExpenditureId,
    "voucher_no": voucherNo,
    "fiscal_years_id": fiscalYearsId,
    "project_id": projectId,
    "project_office_id": projectOfficeId,
    "project_office_name": projectOfficeName,
    "project_proforma_location_master_id": projectProformaLocationMasterId,
    "location_name": locationName,
    "project_proforma_procurement_id": projectProformaProcurementId,
    "package_no": packageNo,
    "package_description": packageDescription,
    "project_procurement_actual_id": projectProcurementActualId,
    "project_procurement_actual_contract_id": projectProcurementActualContractId,
    "voucher_date": "${voucherDate!.year.toString().padLeft(4, '0')}-${voucherDate!.month.toString().padLeft(2, '0')}-${voucherDate!.day.toString().padLeft(2, '0')}",
    "project_expenditure_file_id": projectExpenditureFileId,
    "expenditure_amount": expenditureAmount,
    "project_bank_information_id": projectBankInformationId,
    "bank_name": bankName,
    "account_no": accountNo,
    "account_name": accountName,
    "cheque_no": chequeNo,
    "payment_date": "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
    "base_mode_of_payment": baseModeOfPayment,
    "remarks": remarks,
    "vat_amount": vatAmount,
    "ait_amount": aitAmount,
    "tax_office_id": taxOfficeId,
    "tax_office_name": taxOfficeName,
    "payment_purpose": paymentPurpose,
  };
}
