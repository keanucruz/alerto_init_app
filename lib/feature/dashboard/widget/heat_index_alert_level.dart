import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:groq/groq.dart';

class HeatIndexAlertLevel {
  final groq = Groq(
    apiKey: dotenv.env['GROQ_API_KEY']!,
    model: "deepseek-r1-distill-llama-70b",
  );

  static Future<String> getGroqRecommendation(
      double heatIndex, Groq groq) async {
    groq.startChat();
    GroqResponse response = await groq.sendMessage("""
        tone: friendly and chill 
        language:  taglish
        dont use emojis
        
        Start your sentence with This is what it feels like today: $heatIndex. Is it hot or cold? What should I do? Any recommendations? Make it not longer than 3 sentences, okay?  
        
        If the heat index is:
        Below 0°C (32°F) Freezing (Very cold, frost and ice form) 
        0°C to 10°C (32°F to 50°F) Cold  (Chilly, need a coat or jacket)
        10°C to 20°C (50°F to 68°F) Cool  (Mild, light sweater or jacket)


        20°C to 25°C (68°F to 77°F) Comfortable/Warm  (Pleasant, ideal for most people)


        25°C to 30°C (77°F to 86°F) Warm/Hot  (Might feel hot, especially in the sun)
        30°C to 35°C (86°F to 95°F)  Hot  (Uncomfortable, need hydration)
        35°C to 40°C (95°F to 104°F)  Very Hot  (Risk of heat exhaustion, stay cool)
        Above 40°C (104°F+)  Extremely Hot  (Dangerous, high risk of heatstroke)


        """);
    return response.choices.first.message.content;
  }

  static String getHeatIndexWarning(double heatIndex) {
    if (heatIndex < 27) {
      return 'Not Hazardous';
    } else if (heatIndex >= 27 && heatIndex <= 32) {
      return 'Caution';
    } else if (heatIndex > 32 && heatIndex <= 41) {
      return 'Extreme Caution';
    } else if (heatIndex > 41 && heatIndex <= 51) {
      return 'Danger';
    } else {
      return 'Extreme Danger';
    }
  }
}
