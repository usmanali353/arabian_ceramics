class Product{
  String name,surface,thickness,size,range,material,colour,technology,structure,edge,classification,suitibility, image;

  Product({
      this.name,
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
      this.image});
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
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
    return map;
  }
  Product.fromMap(Map<dynamic,dynamic> data){
    name=data['name'];
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
  }
}