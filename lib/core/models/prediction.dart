class AddressPrediction{
  String placeId;
  String mainText;
  String secondaryText;

  AddressPrediction(){
    this.placeId;
    this.mainText;
    this.secondaryText;
  }
  AddressPrediction.fromJson(Map<String, dynamic> json){
    placeId = json['place_id'];
    mainText = json['structured_formatting']['main_text'];
    secondaryText = json['structured_formatting']['secondary_text'];
  }
}