import 'package:flutter/material.dart';

class Schedule{
  String modelName,modelCode,scheduledById,scheduledOn,scheduledByName,requesterId,requestedDate,surface,thickness,size,range,material,colour,technology,structure,edge,classification;

  Schedule({
      this.scheduledById,
      this.scheduledOn,
      this.scheduledByName,
      this.requesterId,
      this.requestedDate,
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
      this.modelName,
      this.modelCode,

  });
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    // Schedule Details
    map['scheduledById']=scheduledById;
    map['scheduledOn']=scheduledOn;
    map['scheduledByName']=scheduledByName;
    map['requesterId']=requesterId;
    //Scheduled Product Info
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
    return map;
  }
  Schedule.fromMap(Map<dynamic,dynamic> data){
    //Schedule Info
    scheduledById=data['scheduledById'];
    scheduledOn=data['scheduledOn'];
    scheduledByName=data['scheduledByName'];
    requesterId=data['requesterId'];
    requestedDate=data['requestedDate'];
    //Scheduled Product Info
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
  }
}