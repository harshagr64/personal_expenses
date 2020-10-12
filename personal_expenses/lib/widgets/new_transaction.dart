import "package:flutter/material.dart";
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                // onChanged: (val) {
                // titleInput = val;
                // },
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onSubmitted: (_value) => submitData(),
              ),
              TextField(
                // onChanged: (val) {
                // amountInput = val;
                // },
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                onSubmitted: (_value) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(_selectedDate)),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: submitData,
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
