class Product{
  String modelName,modelCode,surface,thickness,size,range,material,colour,technology,structure,edge,classification,suitibility, image,market,client,event,other,status,requestDate,designers,designersObservations,technical_consideration,closeing_date,commercial_decision,customerObservtion;

  Product({
      this.surface,
      this.thickness,
      this.size,
      this.range,
      this.material,
      this.colour,
      this.technology,
      this.structure,
      this.edge,
      this.classification,
      this.suitibility,
      this.image,
      this.market,
      this.client,
      this.event,
      this.other,
      this.status,
      this.requestDate,
      this.modelName,
      this.modelCode,
     this.designers,
     this.designersObservations,
     this.technical_consideration,
  });
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["surface"] = surface;
    map["thickness"] = thickness;
    map["size"] = size;
    map["range"] = range;
    map["material"] = material;
    map["colour"] = colour;
    map["technology"] = technology;
    map["structure"] = structure;
    map["edge"] = edge;
    map["classification"] = classification;
    map["suitibility"] = suitibility;
    map["image"] = image;
    map["market"]=market;
    map["client"]=client;
    map["event"]=event;
    map["other"]=other;
    map["status"]=status;
    map["requestDate"]=requestDate;
    map['modelName']=modelName;
    map['modelCode']=modelCode;
    map['designers']=designers;
    map['designer_observations']=designersObservations;
    map['technical_consideration']=technical_consideration;
    map['closeing_date']=closeing_date;
    map['customer_observation']=customerObservtion;
    return map;
  }
  Product.fromMap(Map<dynamic,dynamic> data){
    surface=data['surface'];
    thickness=data['thickness'];
    size=data['size'];
    range=data['range'];
    material=data['material'];
    colour=data['colour'];
    technology=data['technology'];
    structure=data['structure'];
    edge=data['edge'];
    classification=data['classification'];
    suitibility=data['suitibility'];
    image=data['image'];
    market = data["market"];
    client = data["client"];
    event=data["event"];
    other=data["other"];
    requestDate=data["requestDate"];
    status=data["status"];
    modelName=data['modelName'];
    modelCode=data['modelCode'];
    designers=data['designers'];
    designersObservations=data['designer_observations'];
    technical_consideration=data['technical_consideration'];
    customerObservtion=data['customer_observation'];
    closeing_date= data['closeing_date'];
  }
}