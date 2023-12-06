import 'package:flutter/material.dart';

class appointmentList extends StatelessWidget {
  final String doctor;
  final String category;
  final String date;
  final String time;
  final String state;

  const appointmentList({super.key, 
    required this.doctor,
    required this.category,
    required this.date,
    required this.time,
    required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF0561DD),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      child: Column(
        children: [
          Row(
            children: [
              // 1st col
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dr.
                    Text(
                      'Doctor',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //dr name
                    Text(
                      doctor,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    // Category
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 15,
              ),

              // 2nd col
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // Date
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 15,
              ),

              // 3rd col
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      'Time',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    // Time
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),
          // State
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'State:',
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  state,
                  style: const TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                TextButton(
                  onPressed: () {
                    // Handle reschedule button tap
                  },
                  child: const Text(
                    "Reschedule",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'salsa',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
