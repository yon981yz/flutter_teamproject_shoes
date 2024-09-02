import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/view/user_complite_product.dart';

class UserChoiceBranchPage extends StatefulWidget {
  @override
  _UserChoiceBranchPageState createState() => _UserChoiceBranchPageState();
}

class _UserChoiceBranchPageState extends State<UserChoiceBranchPage> {
  Branch? _selectedBranch;

  Future<List<Branch>> _getBranches() async {
    List<Branch> branches = [
      Branch(id: 1, address: "SB Market 신사점"),
      Branch(id: 2, address: "SB Market 잠실점"),
      Branch(id: 3, address: "SB Market 강남점"),
    ];
    return branches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('매장 위치 선택')), 
      body: FutureBuilder<List<Branch>>(
        future: _getBranches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No branches available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final branch = snapshot.data![index];
                return RadioListTile<Branch>(
                  title: Text(branch.address),
                  value: branch,
                  groupValue: _selectedBranch,
                  onChanged: (Branch? value) {
                    setState(() {
                      _selectedBranch = value;
                    });
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedBranch != null
            ? () {
                 // navigating to usrcompleietproductpage with the selected branch
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserCompliteProductPage(
                      purchaseId: 1,   // example purchaseid it should be dynamic in a real app
                      selectedBranch: _selectedBranch!,
                    ),
                  ),
                );
              }
            : null,   // here disable the button if no branch is selected
        child: Icon(Icons.arrow_forward),
        backgroundColor: _selectedBranch != null ? Colors.blue : Colors.grey,
      ),
    );
  }
}