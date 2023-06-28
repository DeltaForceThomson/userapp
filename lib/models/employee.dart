class Employees
{
  String? name;
  String? uid;
  String? photoUrl;
  String? email;
  String? ratings;

  Employees({
    this.name,
    this.uid,
    this.photoUrl,
    this.email,
    this.ratings,
  });

  Employees.fromJson(Map<String, dynamic> json)
  {
    name = json["name"];
    uid = json["uid"];
    photoUrl = json["photoUrl"];
    email = json["email"];
    ratings = json["ratings"];
  }
}