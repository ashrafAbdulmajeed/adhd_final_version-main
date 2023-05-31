//model for doctors

class Doctor {
  String? id;
  String? name;
  String? job;

  String? image;
  String? address;
  String? phone;
  String? email;

  @override
  String toString() {
    return 'Doctor{id: $id, name: $name, job: $job, image: $image, address: $address, phone: $phone, email: $email}';
  }

  Doctor({
    required this.id,
    required this.name,
    required this.job,
    required this.image,
    required this.address,
    required this.phone,
    required this.email,
  });
  Doctor copyWith({
    String? id,
    String? name,
    String? job,
    String? image,
    String? address,
    String? phone,
    String? email,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      image: image ?? this.image,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'job': job,
      'image': image,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] as String,
      name: map['name'] as String,
      job: map['job'] as String,
      image: map['image'] as String,
      address: map['address'] as String,
      phone: map['phone'].toString(),
      email: map['email'] as String,
    );
  }
}
