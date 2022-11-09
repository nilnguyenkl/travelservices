import 'package:flutter/material.dart';

class DynamicScheduleTicket extends StatefulWidget {
  
  final TextEditingController timeController = TextEditingController();
  final TextEditingController perController = TextEditingController();
  
  DynamicScheduleTicket({Key? key}) : super(key: key);

  @override
  State<DynamicScheduleTicket> createState() => _DynamicScheduleTicketState();
}

class _DynamicScheduleTicketState extends State<DynamicScheduleTicket> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          TextFormField(
            controller: widget.timeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              label: const Text(
                "Time",
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context, 
                    initialTime: const TimeOfDay(hour: 00, minute: 00)
                  );
                  if (newTime == null) {
                    return;
                  }
                  widget.timeController.text = newTime.hour.toString();
                }, 
                icon: const Icon(Icons.schedule)
              )
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: widget.perController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              label: const Text(
                "Quantity Per Day",
              ),
            ),
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    ); 
  }
}
  



