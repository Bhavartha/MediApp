﻿import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'med_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    Directory dbDir = await getApplicationDocumentsDirectory();
    print('got db path');
    var dbPath = dbDir.path + "MediApp.db";

    // Delete any existing database:
    //await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/MediApp.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    //var theDb = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
    var theDb = await openDatabase(dbPath);
    return theDb;
  }

  Future<List<MedData>> getdata([String query=""]) async {
    await Future.delayed(const Duration(seconds: 2));
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM bvk order by name asc");
    List<MedData> md = new List();
    list.forEach((item) {
      md.add(MedData(
          item['name'],
          item['link'],
          item['addr'],
          item['phone'],
          item['pincode'],
          item['map'],
          item['services'],
          item['consultants'],
          item['website'],
          item['img']));
    });
    return md;
  }

  List getservices() {
    return [
      '3 dedicatedoperation theatres with laminar flow ventilation technology',
      'ART Consultant',
      'ASD and VSD surgeries',
      'Abortion/ Medical Termination of Pregnancy (MTP)',
      'Achilles Tendon Rupture Treatment',
      'Acne treatment',
      'Acute (sudden onset) renal diseases',
      'Adolescent Problems',
      'Adolescents Gynecological problems',
      'Aesthetic dermatology',
      'Airway surgery',
      'Ambulatory BP Monitoring',
      'Anesthesia',
      'Anger Management',
      'Angiography',
      'Angiography & Angioplasty',
      'Anti-aging services',
      'Anxiety',
      'Aortic Anuerysm Surgery / Endovascular Repair',
      'Arthroscopic ACL, PCLreconstruction, and Meniscal repair surgeries',
      'Arthroscopic Surgeries for Instability of shoulder and cuff repaair',
      'Arthroscopic rotator cuff repair',
      'Arthroscopic shoulder stabilization',
      'Arthroscopicmeniscus repair/excision',
      'Assessment of behavioral problemsand development delays',
      'Asthma and allergies detection in children',
      'Balloon angioplasty (PTCA) with stenting',
      'Behaviour & Thought Problems',
      'Blastocystculture',
      'Blood Bank',
      'Blood Test',
      'Blood in urine (hematuria) management',
      'Body sculpture & recontouring',
      'Bone Trauma',
      'Bone and Joints%X Ray',
      'Brain Tumors',
      'C-ARM Facility',
      'CABG beating heart surgery',
      'CT- Scan',
      'CVTS',
      'Caesarean Section (C Section)',
      'Cancer Screening',
      'Cardiac Ambulance',
      'Cardiac Care',
      'Cardiac Catheterization and interventional services for children',
      'Cardiac Clinic',
      'Cardiac surgeries',
      'Cardio / Onco Rehab',
      'Cardiography',
      'Cardiology',
      'Child Counselling:',
      'Chronic (slow ongoing decline in renal function) renal diseases',
      'Chronic Pain Treatment',
      'Chronic and recurrent urinary tract infection management',
      'Clinical Pathology',
      'Cochlear Implants',
      'Colposcopy',
      'Complex ovarian cysts',
      'Complex primary arthroplasty',
      'Complicated hysterectomies procedures',
      'Comprehensive imaging for children',
      'Computer navigated joint replacement surgery',
      'Congenital anomalies, evaluation and treatment',
      'Consultation',
      'Contrast echocardiography',
      'Coronary Angiogram',
      'Coronary Angioplasty / Bypass Surgery',
      'Craniotomy',
      'Critical Care',
      'D&C (Dilation andCurettage)',
      'Day and night Pharmacy',
      'Deafness – both from birth and acquired later',
      'Decompression and stabilization for  Tuberculosis of spine',
      'Dental',
      'Depression',
      'Dermatology',
      'Dermatology Clinic',
      'Diabetes',
      'Diabetes Management',
      'Diagnosis',
      'Diagnostic Center',
      'Diagnostic Radiology',
      'Diagnostic arthroscopy and biopsy',
      'Dialysis',
      'Disc replacement',
      'Dissection',
      'Divorce',
      'EEG brain',
      'EMG brain',
      'ENT',
      'Ear Ache',
      'Ear deformities – Microtia / Bat ears etc.',
      'Ear discharge',
      'Ear tumors treament .',
      'Ear/Nose/ThroatClinic',
      'Early Parenting Issues',
      'Early pregnancy Issues',
      'Echocardiogram',
      'Ectopic pregnancies',
      'Electrocardiogram (ECG)',
      'Electrolyte or acid-base imbalance correction',
      'Embryo adoption',
      'Emotional Outbursts',
      'Endometriosis',
      'Endomyocardial biopsy',
      'Endoscopic excision of intraventricular tumors',
      'Endoscopy',
      'Endovascular',
      'Epilepsy',
      'Evacuation of brain hematomas',
      "Evaluation of mental retardation, Down'S syndrome",
      'External fixator',
      'Face Lift',
      'Facial paralysis secondary to ear disease treament',
      'Family Planning',
      'Family Problems',
      'Fertility enhancing diagnostic',
      'Fibroids',
      'First Aid',
      'Foetal cardiac services',
      'Fracture Treatment',
      'Freezing of eggs',
      'Freezing of embryos (vitrification)',
      'Freezingof sperms',
      'Frozen shoulder Physiotherapy',
      'GENERAL MEDICINE',
      'Gastroenterology Dept With Endoscopy',
      'General Medical ',
      'General Medical Consultation',
      'General Medicine',
      'General Surgery',
      'General pediatrics',
      'Genetic disorders, genetic counseling',
      'Geriatric Problems',
      'Giant Aneurysm',
      'Giddiness (vertigo) assessment',
      'Govt.Reg. M.T.P. Centre',
      'Grief',
      'Growth and development assessment',
      'Gynae Problems',
      'Gynaec. Surgeries',
      'GynaecConsultation',
      'Gynaecological Clinic',
      'Gynaecology',
      'Gynecology',
      'Haemorrhage Treatment',
      'Hair disorders',
      'Hand Pain Treatment',
      'Head Up Tilt Test (HUTT)',
      'Hearing Aids',
      'Hereditary and metabolic disorders',
      'Hereditary renal disorders',
      'Hernia Repair Surgery',
      'High Risk Pregnancy',
      'High precision modern equipments',
      'Hip Replacement',
      'Hip Resurfacing',
      'Hip, Ankle, Knee Injury',
      'Holter monitoring',
      'Hysterectomy (Abdominal/Vaginal)',
      'ICSI (intracytoplasmic sperm injection)',
      'ICU',
      'IUI (intrauterine insemination)',
      'Image guided spine surgery',
      'Immunization',
      'Implant services- cheek, chin, breast, calf implants',
      'In-Vitro Fertilization (IVF)',
      'Infections and infectious diseases treatment',
      'Infertility Clinic',
      'Infertility Evaluation / Treatment',
      'Infertility Service',
      'Insomnia (Sleeplessness)',
      'Insulin Treatment',
      'Intensive Care',
      'Internal mammary',
      'Interventional Neurology',
      'Interventional Neuroradiology',
      'Interventional Radiology',
      'Interventional neuro-radiology',
      'Intra-Uterine Insemination (IUI)',
      'Intra-aortic balloon pump (IABP) Insertion',
      'Intravascular ultrasound (IVUS) for Mechanical Thrombectomy System',
      'Invasive Cardiology',
      'Joint Dislocation Treatment',
      'Joint Mobilization',
      'Joint Replacement Surgeries',
      'Joint Replacement Surgery',
      'Joint and Muscle Problems',
      'Kidney Transplant',
      'Knee Braces For Osteoarthritis',
      'Knee Osteotomy',
      'Knee Replacement',
      'Knee care',
      'LGBT Counselling',
      'Lab Tests',
      'Laparoscopic Surgery',
      'Laparoscopy',
      'Laryngotracheal injuries correction',
      'Laser liposuction',
      'Laser skin resurfacing',
      'LaserAssisted hatching',
      'Lasers therapies',
      'Ligament reconstruction',
      'Limb Deformities',
      'Liposuction',
      'Low Confidence',
      'Low Self esteem',
      'Lower Back Pain, Neck Pain',
      'Lung surgeries like lobectomy, pneumonectomy etc.',
      'MDS (Oral Surgery)',
      'MRI machine',
      'Marriage Counselling',
      'Maternal care',
      'MaternalCare/ Checkup',
      'Maternity Department',
      'Maxillo Facial Surgery',
      'Mediastinal tumour excision',
      'Medical Oncology',
      'Menstrual dysfunction treatment',
      'Minimally Invasive Hip Correction',
      'Minimally Invasive Knee Correction',
      'Minimally Invasive Surgery',
      'Minimally invasive endoscopic surgery.',
      'Musculoskeletal Pain Management',
      'Nail disorders',
      'Nephrology',
      'Neuro Surgery',
      'Neurology',
      'Neuroradiology',
      'Neurovascular',
      'Non Invasive Cardiology',
      'Non-Invasive Cardiology',
      'Normal Vaginal Delivery (NVD)',
      'Normal deliveries',
      'Nose fractures',
      'OCD',
      'OPD',
      'Obestriatics & Gynaecology',
      'Obstetric',
      'Obstetrics & Gynaecology',
      'Onco Surgery',
      'Oncology',
      'Online Counselling',
      'Open/minimally invasive discectomy',
      'Operation Theater',
      'Opthamology',
      'Orthopaedics',
      'Orthopedic',
      'Orthopedic and spine deformity correction surgerywith cell saver',
      'Orthopedics',
      'Orthopedics / Replacement',
      'Orthopedicsurgeries',
      'Osteoporosis Treatment',
      'Out-patient / office hysteroscopy interventions.',
      'PCOD',
      'PESA',
      'PGD (Pre-implantation genetic  diagnosis)',
      'Pacemaker Implantation',
      'Paediatric and foetal echocardiography',
      'Pain Management',
      'Parenting',
      'Parenting Issues & Doubts',
      'Pathology Lab',
      'Pediatric',
      'Pediatric Cardiology',
      'Pediatric Department',
      'Pediatric Neurology',
      'Pediatric cardiology',
      'Pediatric congenital heart surgeries',
      'Pediatric emergencies',
      'Pediatrics Ophthalmology',
      'Peripheral angiography with angioplasty',
      'Pharmacy',
      'Phobias',
      'Phonosurgery',
      'Physiotherapy',
      'Physiotherapy Center',
      'Physiotherapy for Sports Injury Rehabilitation',
      'Piles Surgery',
      'Plastic Surgery',
      'Post Traumatic Stress Disorder (PTSD)',
      'Pre Marital Problems',
      'Pregnancy Problems',
      'Primary Health Care',
      'Primary Hip and Knee Arthroplasty',
      'Primary and revision - total hip replacement',
      'Protein loss in urine (proteinuria) management',
      'Psychiatric',
      'Psychiatric Department',
      'Pulmonology',
      'Reconstruction & Rehabilitation',
      'Removal of extruded intervertebral disc',
      'Renovascular Diseases',
      'Revision Hip and Knee Arthroplasty',
      'Revision Surgery',
      'Rhinology',
      'Rhinoplasty',
      'SVG graft angiography',
      'Scar Revision Surgery',
      'Semen analysis',
      'Shoulder Pain',
      'Simple primary arthroplasty',
      'Skin allergy treatments',
      'Skull base surgery',
      'Snoring / Sleep Apnea',
      'Spinal Therapy',
      'Spinal cord tumors',
      'Spinal deformities correction',
      'Spine Surgery',
      'Stress Management',
      'Stroke management',
      'Sub Arachnoid',
      'Superficial femoralartery atherectomy using 2D echocardiography with colour Doppler',
      'Surgery Theatre',
      'Surgical problems correction in babies and children',
      'Surrogacy',
      'Swallowing disorders',
      'TESA',
      'TOF surgery',
      'Test tube Baby Centre',
      'Thyroid',
      'Tonsillitis',
      'Total Heart Care & diabetic Clinic',
      'Total Knee and hip replacemen',
      'Total lap hysterectomies',
      'Trans-oesophageal echocardiography',
      'Transplant',
      'Trauma / Emergency Care',
      'Trauma care',
      'Tread Mill Test (TMT)',
      'Tubectomy/Tubal Ligation',
      'Ultra Sonography',
      'Ultra Sonography (Routine & Dopplers)',
      'Ultrasonography',
      'Ultrasound',
      'Urology',
      'Urology/ Oncology/ Neurology Clinic',
      'VOICE disorders correction',
      'Valve Replacements',
      'Video-assisted thoracoscopy',
      'Vocal Cord paralysis',
      'Well- equipped operation theateres',
      'X-Ray',
      'ectopic pregnancies',
      'family planning centre',
      'fertility enhancing diagnostic & operative laparoscopy and hysteroscopy as well as out-patient / office hysteroscopic interventions',
      'info na',
      'joint replacements - shoulder, elbow, small joints of hands and feet',
      'laparoscopic expertise includes management of complex ovarian cysts',
      'operative laparoscopy and hysteroscopy',
      'total lap hysterectomies',
      'work related counselling'
    ];
  }
}
