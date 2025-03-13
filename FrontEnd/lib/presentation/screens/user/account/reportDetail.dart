import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/aReport_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/aReport_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportDetailScreen extends StatefulWidget {
  final int complaintId;

  const ReportDetailScreen({super.key, required this.complaintId});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<AReportCubit>(context).getAReport(widget.complaintId);
    });
    _fetchMessages();
    _listenForRealtimeMessages();
  }

  void _fetchMessages() async {
    try {
      final response = await supabase
          .from('complaintMessages')
          .select('*')
          .eq('complaintId', widget.complaintId)
          .order('createdAt', ascending: true);

      setState(() {
        messages = response
            .where((msg) => msg['message'] != null && msg['sender'] != null)
            .map((msg) => {
                  "text": msg['message'],
                  "sender": msg['sender'], // Lưu nguyên giá trị sender
                })
            .toList();
      });
    } catch (e) {
      debugPrint("Error fetching messages: $e");
    }
  }

  void _listenForRealtimeMessages() {
    supabase
        .from('complaintMessages')
        .stream(primaryKey: ['id'])
        .eq('complaintId', widget.complaintId)
        .listen((data) {
          if (data.isNotEmpty && data.last.containsKey('message')) {
            setState(() {
              messages.add({
                "text": data.last['message'],
                "sender": data.last['sender']
              });
            });
          }
        });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      await supabase.from('complaintMessages').insert({
        "complaintId": widget.complaintId,
        "sender": "customer",
        "message": _messageController.text.trim(),
      });
      _messageController.clear();
      setState(() {}); // Cập nhật lại UI sau khi gửi tin nhắn
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AReportCubit, AReportState>(
      builder: (context, state) {
        if (state is AReportLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AReportSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Chi tiết khiếu nại",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Khiếu nại #${state.report.id ?? ""}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("TaskId: ${state.report.taskId ?? ""}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Type: ${state.report.type ?? ""}",
                              style: const TextStyle(fontSize: 16)),
                          Text("Status: ${state.report.status ?? ""}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("Description: ${state.report.description ?? ""}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Hoàn thành",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isUser = messages[index]["sender"] != "admin";
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue[300] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(messages[index]["text"],
                              style: const TextStyle(fontSize: 16)),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Colors.grey[300]!))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                              hintText: "Nhập tin nhắn...",
                              border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.teal),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is AReportError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
