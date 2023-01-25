import 'package:flutter/material.dart';

import 'models/Id_wise_beneficiary_model.dart';

class BeneficiaryDetail extends StatefulWidget {
  final IdWiseBeneficiaryModel idWiseBeneficiaryModel;
  BeneficiaryDetail({super.key, required this.idWiseBeneficiaryModel});

  @override
  State<BeneficiaryDetail> createState() => _BeneficiaryDetailState();
}

class _BeneficiaryDetailState extends State<BeneficiaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("বেনেফিসারির বিস্তারিত তথ্য"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                "Name: Omar Faruk \n\n Mobile: 01243543543 \n\n Address: Dhaka"),
            // Text(idWiseBeneficiaryModel.id.toString())
          ],
        ),
      ),
    );
  }
}
