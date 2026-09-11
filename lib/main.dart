// double processOrder({
//   required int orderId,
//   required double itemPrice,
//   String? promoCode,
//   double? delyveryFee,
// }){
//   double finalPrice = itemPrice;
//   if(promoCode == "SAVE10"){
//     finalPrice *= 0.9;
//   }

//   double deliveryFee = delyveryFee ?? 500.0;

//   double total=finalPrice + deliveryFee;

//   return total;
// }

// void main() {
//   print("Total price: ${processOrder(orderId: 1, itemPrice: 1000.0, promoCode: "SAVE10", delyveryFee: 200.0)}");
//     print("Total price: ${processOrder(orderId: 2, itemPrice: 1000.0, promoCode: "SAVE10")}");
//     print("Total price: ${processOrder(orderId: 3, itemPrice: 1000.0)}");
// }

// void main() {
//   String name = "Bekzat";
//   int age = 25;
//   double gpa = 3.4;
//   bool isStudent = false;

//   print("name : $name\nage: $age y.o.\ngpa: $gpa\nis Teacher: ${!isStudent}");

//   String text1 = "Hello";
//   // String nullText = null; not works
//   String? text2 = null;
//   print('text1: $text1');
//   print('text2: $text2');

//   int length1 = text1.length;
//   int length2 = text2?.length ?? 0;
//   print(length1);
//   print(length2);

//   String confirmedText = text2 ?? "default";
//   print("confirmed $confirmedText length: ${confirmedText.length}");

//   int digit = 3;
//   print("MULTIPLICATION TABLE for digit $digit");
//   for (int i = 1; i <= 10; i++) {
//     print("$digit * $i = ${i * digit}");
//   }

//   for (int i = 10; i > 0; i--) {
//     if (i % 2 == 0) {
//       print("$i");
//     } else {
//       print("${i * 2}");
//     }
//   }
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


void checkbalance({
  required String name,
  required double balance
})=>print("$name, your balance is: $balance");

double deposit({
  required double currentBalance,
  required double amount
}){ 
  double depositAmount=amount??0.0;

  if(depositAmount<=0){
    print("Deposit amount must be greater than 0");
    return currentBalance;
  }

  double newBalance=currentBalance+depositAmount;
  print("Deposit successfull. New balance: $newBalance");
  return newBalance;
}

  double withdraw({
    required String name,
    required double currentBalance,
    double? amount,
    int? pinCode,}){

      int enteredPin=pinCode??0000;
      if(enteredPin!=1234){
        print("Incorrect pin Code");
        return currentBalance;
      }

      double withdrawAmount=amount??0.0;

      if(withdrawAmount<=0){
        print("Withdraw amount must be greater than 0");
        return currentBalance;
      }

      if(withdrawAmount>currentBalance){
        print("You re too poor go get a job");
        return currentBalance;
      }

      double newBalance= currentBalance-withdrawAmount;
      print("Withdraw successfull. New balance: $newBalance");
      return newBalance;}

      void main(){
        double balance=10000.0;
        String name="Adi";

        checkbalance(name: name, balance: balance);
        balance=deposit(currentBalance: balance, amount: 0.0);
        balance=deposit(currentBalance: balance, amount: 5000.0);
        balance=withdraw(name: name, currentBalance: balance, amount: 2000.0, pinCode: 12345);
        balance=withdraw(name: name, currentBalance: balance, amount: 20000.0, pinCode: 1234);
        balance=withdraw(name: name, currentBalance: balance, amount: 500.0, pinCode: 1234);

        print("Final balance for $name: $balance");
              }







