class Product{
  String surface,thickness,size,range,material,colour,technology,structure,edge,classification,suitibility, image,requestedBy,market,client,event,other,status,requestDate,requesterName;

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
      this.requestedBy,
      this.market,
      this.client,
      this.event,
      this.other,
      this.status,
      this.requestDate,
      this.requesterName,
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
    map['requestedBy']=requestedBy;
    map["market"]=market;
    map["client"]=client;
    map["event"]=event;
    map["other"]=other;
    map["status"]=status;
    map["requestDate"]=requestDate;
    map['requesterName']=requesterName;
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
    requestedBy=data['requestedBy'];
    market = data["market"];
    client = data["client"];
    event=data["event"];
    other=data["other"];
    requestDate=data["requestDate"];
    status=data["status"];
    requesterName=data['requesterName'];
  }
}