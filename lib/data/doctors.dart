import 'package:adhd_app/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//list of doctors
List<Doctor> doctors = [
  Doctor(
      id: 1.toString(),
      name: 'DR.Mohamed Ahmed',
      job: "ADHD Specialist",
      image: 'doctor',
      email: "DR.MohhamadA@gmail.com",
      phone: "0550255967",
      address: 'ABHA'),
  Doctor(
      id: 3.toString(),
      name: 'DR.Asma Ali',
      job: "ADHD Specialist",
      image: 'doctor2',
      email: "DR.AsmaA@gmail.com",
      phone: "0581955650",
      address: 'ABHA'),
  Doctor(
      id: 2.toString(),
      name: 'DR.Esmail khalid',
      job: "DR.ADHD Specialist",
      image: 'doctor',
      email: "DR.EsmailKh@gmail.com",
      phone: "0502399166",
      address: 'Khamis Mushait'),
];

Future<void> addDoctors(List<Doctor> doctors) async {
  try {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('doctors');
    for (Doctor doctor in doctors) {
      final docRef = collectionRef.doc();
      await docRef.set({
        'id': docRef.id,
        'name': doctor.name,
        'job': doctor.job,
        'image': doctor.image,
        'email': doctor.email,
        'phone': doctor.phone,
        'address': doctor.address,
      });
    }
    print('Doctors added successfully');
  } catch (e) {
    print('Failed to add doctors: $e');
  }
}

