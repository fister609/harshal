import 'package:flutter/material.dart';

class GFG extends StatefulWidget {
  const GFG({Key? key}) : super(key: key);

  @override
  State<GFG> createState() => _GFGState();
}

class _GFGState extends State<GFG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Search',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SearchPage(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    'Harshal Tak','Nishant Shinde','Raj Shinde','Pratik Wangaskar','Mahesh Shriram'
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: (){

          },
        );
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var AIDS = ['Harshal Tak','Nishant Shinde','Raj Shinde','Pratik Wangaskar','Mahesh Shriram'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*Padding(
                padding: EdgeInsets.only(top:16,left: 16,right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade600,size:20),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ),
                  onTap: (){
                  },
                ),
              ),*/
              SizedBox(height: 30),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildText(context),
                    SizedBox(height: 20),
                    buildText2(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
  Widget buildText(BuildContext context) => SingleChildScrollView(
    child: ExpansionTile(
      title: Text(
        'Artificial Intelligence and Data Science',
        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
      ),
      children: [
        ListView.builder(
            itemCount: AIDS.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage('https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg'),radius: 17,),
                title: Text(AIDS[index]),
                onTap: (){

                },
              );
            }),
      ],
    ),
  );

  Widget buildText2(BuildContext context) => SingleChildScrollView(
    child: ExpansionTile(
      title: Text(
        'Artificial Intelligence and Machine Learning',
        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
      ),
      children: [
        ListView.builder(
            itemCount: AIDS.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage('https://i.pinimg.com/736x/09/24/a7/0924a7ef295741e916c8f42512bbe5bd.jpg'),radius: 17,),
                title: Text(AIDS[index]),
                onTap: (){

                },
              );
            }),
      ],
    ),
  );
}
