import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../domain/models/view_risk_detail_response.dart';

class RiskActionItem extends StatefulWidget {
  final ActionList action;
  final String currentUserId;
  final String userRole;

  const RiskActionItem({
    super.key,
    required this.action,
    required this.currentUserId,
    required this.userRole,
  });

  @override
  State<RiskActionItem> createState() => _RiskActionItemState();
}

class _RiskActionItemState extends State<RiskActionItem> {
  bool showStatusSelector = false;

  Color _tierColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'primary':
        return Colors.green;
      case 'secondary':
        return Colors.orange;
      case 'tertiary':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Widget _statusImage(String status) {
    switch (status.toLowerCase()) {
      case 'started':
        return Image.asset('assets/started.png', height: 15, width: 80);
      case 'completed':
        return Image.asset('assets/complete.png', height: 15, width: 80);
      default:
        return Image.asset('assets/notstarted.png', height: 15, width: 80);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: widget.userRole != '3' || widget.currentUserId == widget.action.userId,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (_) => {

            },
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) => {

            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(widget.action.name!, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  if (!["department", "office", "individual"].contains(widget.action.tier!.toLowerCase()))
                    Container(
                      color: _tierColor(widget.action.tier!),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        widget.action.tier!,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () => {

                    },
                  )
                ],
              ),
              // Description
              Text(widget.action.description!),
              const Divider(),
              // Dates
              Row(children: [
                const Text("Start Date: "),
                Text(widget.action.startedDate!),
              ]),
              Row(children: [
                const Text("Due Date: "),
                Text(widget.action.dueDate!),
              ]),
              // Status
              Row(
                children: [
                  const Text("Status: "),
                  GestureDetector(
                    onTap: () {
                      setState(() => showStatusSelector = !showStatusSelector);
                    },
                    child: _statusImage(widget.action.orgStatus!),
                  ),
                ],
              ),
              if (showStatusSelector)
                Row(
                  children: [
                    _statusButton("Not Started"),
                    _statusButton("Started"),
                    _statusButton("Completed"),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() => showStatusSelector = false),
                    )
                  ],
                ),
              // Responsible
              Row(children: [
                const Text("Responsible: "),
                Text(widget.action.responsibleName!),
              ]),
              // Linked Themes
              if (widget.action.themes!.isNotEmpty)
                Row(children: [
                  const Text("Linked Risks: "),
                  Expanded(
                    child: Text(widget.action.themes!.map((e) => e.title).join(", ")),
                  )
                ]),
              // Linked Offloads
              if (widget.action.linkedActionOffloads!=null)
                Row(children: [
                  const Text("Linked Offloads: "),
                  Text(widget.action.linkedActionOffloads.toString()),
                ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusButton(String status) {
    final bool isSelected = widget.action.orgStatus!.toLowerCase() == status.toLowerCase();
    return TextButton(
      onPressed: () {

        setState(() => showStatusSelector = false);
      },
      child: Text(
        status,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        ),
      ),
    );
  }
}
