// double proccessOrder({
//   required String OrderId,
//   required double itemPrice,
//   String? PromoCode,
//   double? deliveryFee
// }){
//   double finalPrice=itemPrice;
//   if(PromoCode=="SAVE10"){
//     finalPrice=itemPrice*0.9;
//   }
//   double finalDelivery=deliveryFee??500.0;
//   double total=finalDelivery+finalPrice;

//   print("$OrderId");
//   print("$total");

//   return total;
// }
// void main(){
//   proccessOrder(OrderId: '101', itemPrice: 2000, PromoCode: "SAVE10",deliveryFee: 300);
// }
// TASK 1
// OUTPUT MULTIPLICATION TABLE  1-10

// void printMultiplicationTable() {
//   for(int i=1;i<=10;i++){
//     print("Multiplication Table for $i");
//     for(int j=1;j<=10;j++){
//       print("$i * $j = ${i*j}");
//     }
//     print("--------------------");
//   }}

//   void main() {
//     printMultiplicationTable();
//   }

 
// TASK 2
// next day : examples:
// 05.09.2026 -> 06.09.2026
// 28.02.2024 -> 29.02.2024
// 28.02.2026 -> 01.03.2026
// 29.02.2026 -> invalid date
// 28.02.2100 -> 01.03.2100
// 28.02.2100 -> 29.02.2000
// 31.12.2025 -> 01.01.2026
// 2000,2400 leap year
// 2100,2200,2300 isn`t leap year

// bool isLeapYear(int year) {
//   return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
// }

// void printNextDate(int day, int month, int year) {
//   List<int> days = [31, isLeapYear(year) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
//   int maxDays = days[month-1];
//   if(month<1 || month>12 || day<1 || day>maxDays){
//     print('Invalid date');
//     return;
//   }
//   day++;

//   if (day>maxDays){
//     day=1;
//     month++;
//     if (month>12){
//       month=1;
//       year++;}}

//   String formattedDay=day<10?'0$day' : '$day';
//   String formattedMonth=month<10?'0$month' : '$month';
//   print('Следующая дата: $formattedDay.$formattedMonth.$year');}

// void main(){
//   printNextDate(32, 2, 2100);
// }

// TASK3
// Vowel Counter in a String -> "flutter mobile development" -> 8

  // int countVowels(String input) {
  //   String vowels = 'aeiouAEIOU';
  //   int count = 0;
  //   for (int i = 0; i < input.length; i++) {
  //     if (vowels.contains(input[i])) {
  //       count++;
  //     }
  //   }
  //   return count;
  // }void main(){
  //   String text="flutter mobile development";
  //   int result=countVowels(text);
  //   print("Number of vowels in '$text': $result");
  // }

// List<int> numbers = [14, 88, 3, 42, 99, 12, 67]; //-> max: 99, min: 3
// List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67]; //-> max: 949, min: 34
// int first = numbers[0];
// int last = numbers[numbers.length - 1];
// TASK4
// Manual min & max finder

// void findMinMax(List<int> list) {
//   int min=list[0];
//   int max=list[0];
//   for(int num in list){
//     if(num<min)min=num;
//     if(num>max){max=num;}
//   }
//   print("Min: $min, Max: $max");
// }
// void main(){
//   findMinMax(numbers);
//   findMinMax(numbers1);
// }

// TASK 5
// Prime Number Checker
// 3 -> prime number
// 6 -> not prime number

// bool isPrime(int number){
//   if(number<=1)return false;
//   for(int i=2;i*i<=number;i++){
//     if(number%i==0)return false;
//   }
//   return true;
// }
// void main(){
//   int number1=3;
//   int number2=6;
//   print("$number1 is ${isPrime( number1) ? 'a prime number' : 'not a prime number'}");
//   print("$number2 is ${isPrime( number2) ? 'a prime number' : 'not a prime number'}");
// }

// HW 2

// void checkbalance({
//   required String name,
//   required double balance
// })=>print("$name, your balance is: $balance");

// double deposit({
//   required double currentBalance,
//   required double amount
// }){ 
//   double depositAmount=amount??0.0;

//   if(depositAmount<=0){
//     print("Deposit amount must be greater than 0");
//     return currentBalance;
//   }

//   double newBalance=currentBalance+depositAmount;
//   print("Deposit successfull. New balance: $newBalance");
//   return newBalance;
// }

//   double withdraw({
//     required String name,
//     required double currentBalance,
//     double? amount,
//     int? pinCode,}){

//       int enteredPin=pinCode??0000;
//       if(enteredPin!=1234){
//         print("Incorrect pin Code");
//         return currentBalance;
//       }

//       double withdrawAmount=amount??0.0;

//       if(withdrawAmount<=0){
//         print("Withdraw amount must be greater than 0");
//         return currentBalance;
//       }

//       if(withdrawAmount>currentBalance){
//         print("You re too poor go get a job");
//         return currentBalance;
//       }

//       double newBalance= currentBalance-withdrawAmount;
//       print("Withdraw successfull. New balance: $newBalance");
//       return newBalance;}

//       void main(){
//         double balance=10000.0;
//         String name="Adi";

//         checkbalance(name: name, balance: balance);
//         balance=deposit(currentBalance: balance, amount: 0.0);
//         balance=deposit(currentBalance: balance, amount: 5000.0);
//         balance=withdraw(name: name, currentBalance: balance, amount: 2000.0, pinCode: 12345);
//         balance=withdraw(name: name, currentBalance: balance, amount: 20000.0, pinCode: 1234);
//         balance=withdraw(name: name, currentBalance: balance, amount: 500.0, pinCode: 1234);

//         print("Final balance for $name: $balance");
//               }


// LW3

// class Book{
//   String title;
//   String author;
//   double price;
//   bool isBorrowed;

//   Book(this.title, this.author, this.price, {this.isBorrowed=false});

// }

//   class Library{
//     final List<Book> _books=[];

//     void addBook(Book book)=> _books.add(book);

//     List<Book> getAvailableBooks(){
//       return _books.where((book)=>book.isBorrowed==false).toList();
//     }

//     double getTotalValue(){
//       return _books.fold(0.0, (sum, book) => sum + book.price);
//     }
//   }

//   void main(){
//     var lib= Library();
//     lib.addBook(Book("1987", "George Orwell", 15.99));
//     lib.addBook(Book("To Kill a Mockingbird", "Harper Lee", 12.99, isBorrowed: true));
//     lib.addBook(Book("Rich Dad Poor Dad", "Robert Kiyosaki", 10.50));
  
//   print("Available books:");
//   for(var book in lib.getAvailableBooks()){
//     print("${book.title} by ${book.author}, Price: \$${book.price}");
//   }
//   print("Total value of all books: \$${lib.getTotalValue().toStringAsFixed(2)}");
//   }


// HW 3

// abstract class MediaItem{
//   String id;
//   String title;
//   double price;

//   MediaItem(this.id, this.title, this.price);

//   String getDetails();
// }

// mixin Downloadable{
//   void download(String title){
//     print("Downloading $title...");
//   }
// }

// class Audiobook extends MediaItem with Downloadable{
//   double durationHours;
//   String narrator;

//   Audiobook(String id, String title, double price, this.durationHours, this.narrator): super(id, title, price);

//   @override
//   String getDetails()=>"Audiobook: $title, Narrator: $narrator, Duration: ${durationHours}h, Price: \$${price}";
// }

// class EBook extends MediaItem with Downloadable{
//   double fileSizeMB;
//   String author;

//   EBook(String id, String title, double price, this.fileSizeMB, this.author): super(id, title, price);

//   @override
//   String getDetails()=>"EBook: $title, Author: $author, Size: ${fileSizeMB} MB, Price: \$${price}";
// }


// class ShoppingCart{
//   final List<MediaItem> _items=[];

//   void addItem(MediaItem item)=> _items.add(item);

//   double calculateTotalWithTax({double taxRate=0.12}){
//     double total=_items.fold(0.0, (sum,item)=>sum+item.price);
//     return total * (1+taxRate);
//   }

//   List<MediaItem> filterByMaxPrice(double maxPrice)
// {
//   return _items.where((item)=>item.price<=maxPrice).toList();
// }

//   void printReceipt(){
//     print("===Receipt===");
//     for(var item in _items){
//       print(item.getDetails());
//       if(item is Downloadable){
//         (item as Downloadable).download(item.title);
//       }
//     }
//     print("Total with tax: \$${calculateTotalWithTax().toStringAsFixed(2)}");
//   }
// }

//   void main(){
//     var cart=ShoppingCart();

//     cart.addItem(Audiobook("1", "Atom Habits", 20.0, 5.5, "James Clear"));
//     cart.addItem(Audiobook("2", "The Power of Habit", 15.0, 4.0, "Charles Duhigg"))
//     ;
//     cart.addItem(EBook("3", "Rich Dad Poor Dad", 10.0, 2.5, "Robert Kiyosaki"));
//     cart.printReceipt();

//     print("Filtered Items:" );
//     var cheapItems=cart.filterByMaxPrice(18.0);
//     for(var item in cheapItems){
//       print(item.getDetails());
//     }
//   }


// // lw 6
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const SportNutritionApp());
// }

// class SportNutritionApp extends StatelessWidget {
//   const SportNutritionApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Sport Nutrition Store",
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const RegistrationScreen(),
//     );
//   }
// }

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey =GlobalKey<FormState>();

//   final TextEditingController _fullNameController =TextEditingController();
//   final TextEditingController _emailController =TextEditingController();
//   final TextEditingController _passwordController =TextEditingController();
//   final TextEditingController _confirmPasswordController =TextEditingController();

//   bool _isPasswordObscured=true;
//   bool _isConfirmPasswordObscured =true;
//   bool _termsAccepted =false;
//   bool _termsError=false;
//   String _selectedRole = 'Customer'; 

//   final List<String> _roles = ['Customer', 'Trainer', 'Athlete'];

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     setState(() {
//       _termsError=!_termsAccepted;
//     });

//     if (_formKey.currentState!.validate() && _termsAccepted) {
//       print('=== Sport Nutrition Store: New User ===');
//       print('Full Name: ${_fullNameController.text.trim()}');
//       print('Email: ${_emailController.text.trim()}');
//       print('Password: ${_passwordController.text}');
//       print('Role: $_selectedRole');
//       print('Terms Accepted: $_termsAccepted');

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Registration Successful! Welcome, ${_fullNameController.text.trim()}!'),
//           backgroundColor: Colors.deepPurple,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//     } else if (!_termsAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please accept the Terms & Conditions to register.'),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Column(
//                     children: const [
//                       Icon(Icons.fitness_center, size: 64, color: Colors.deepPurple),
//                       SizedBox(height: 8),
//                       Text(
//                         'Sport Nutrition Store',
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
//                       ),
//                       SizedBox(height: 4),
//                       Text('Join us to get your supplements', style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 TextFormField(
//                   controller: _fullNameController,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name *',
//                     prefixIcon: const Icon(Icons.person, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Please enter your full name';
//                     }
//                     return null;
//                   },),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email *',
//                     hintText: 'athlete@narxoz.kz',
//                     prefixIcon: const Icon(Icons.email, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   validator:(value) {
//                     if (value ==null||value.trim().isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!value.contains('@') ||!value.contains('.')) {
//                       return 'Enter a valid email containing "@" and "."';
//                     }
//                     return null;
//                   },),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller:_passwordController,
//                   obscureText:_isPasswordObscured,
//                   decoration: InputDecoration(
//                     labelText:'Password *',
//                     prefixIcon:const Icon(Icons.lock, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                     suffixIcon: IconButton(
//                       icon: Icon(_isPasswordObscured ? Icons.visibility_off : Icons.visibility),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordObscured = !_isPasswordObscured;
//                         });
//                       },),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters long';
//                     }
//                     return null;
//                   },),
//                 const SizedBox(height: 16),

//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   obscureText:_isConfirmPasswordObscured,
//                   decoration:InputDecoration(
//                     labelText:'Confirm Password *',
//                     prefixIcon:const Icon(Icons.lock_outline, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
//                     suffixIcon: IconButton(
//                       icon: Icon(_isConfirmPasswordObscured?Icons.visibility_off : Icons.visibility),
//                       onPressed: () {
//                         setState(() {
//                           _isConfirmPasswordObscured=!_isConfirmPasswordObscured;
//                         });},
//                     ),),
//                   validator: (value) {
//                     if (value==null||value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     if (value != _passwordController.text) {
//                       return 'Passwords do not match'; }
//                     return null;
//                   },),
//                 const SizedBox(height: 16),

//                 DropdownButtonFormField<String>(
//                   value: _selectedRole,
//                   decoration: InputDecoration(
//                     labelText: 'Select Profile Type',
//                     prefixIcon: const Icon(Icons.badge, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),),
//                   items:_roles.map((String role) {
//                     return DropdownMenuItem<String>(
//                       value:role,
//                       child:Text(role),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue !=null) {
//                       setState((){
//                         _selectedRole=newValue;
//                       });
//                     } }, ),
//                 const SizedBox(height: 16),


//                 Row(
//                   children: [
//                     Checkbox(
//                       activeColor:Colors.deepPurple,
//                       value:_termsAccepted,
//                       onChanged: (bool?value) {
//                         setState(() {
//                           _termsAccepted=value ??false;
//                           if (_termsAccepted) _termsError=false;
//                         });
//                       },
//                     ),
//                     const Expanded(
//                       child: Text('I accept the Terms and Conditions *'),
//                     ),
//                   ],
//                 ),
//                 if (_termsError)
//                   const Padding(
//                     padding: EdgeInsets.only(left:12.0),
//                     child: Text(
//                     'You must accept the terms to register',
//                     style: TextStyle(color: Colors.red, fontSize: 12),
//                     ),
//                   ),
//                 const SizedBox(height: 24),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                   onPressed: _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),),
//                     ),
//                     child: const Text(
//                       'Register Now',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
//                 ),
//               ],),
//           ),
//         ),
//       ),
//     );
//   }
// }