import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';


class DateEvent {
  final _targetUrl = 'http://www.siue.edu/news/current.xml';

  Future<AtomFeed> getFeed() =>
      http.read(_targetUrl).then((xmlString) => AtomFeed.parse(xmlString));
}



// class Date {
//   final String day;
//   final String event;
//   //final String description;

  

//   Date(this.day, this.event,);
// }

// List<Date> dateEvents = []
//     ..add(Date('April 4', 'Music in the Park'))
//     ..add(Date('April 11', 'Jazz on a Bus'))
//     ..add(Date('April 16', 'Jazz on a Train'))
//     ..add(Date('April 20', 'April Blast'))
//     ..add(Date('April 26', 'Execute Order 66'));