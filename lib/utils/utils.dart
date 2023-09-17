import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

Color mainBlue = const Color.fromARGB(255, 3, 0, 207);
Color lightBlue = const Color.fromARGB(255, 121, 168, 255);



LinearGradient gradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [lightBlue,mainBlue],
  );

  
  
                                            
TextStyle textStyle(double size, Color color, FontWeight fw){
  return GoogleFonts.montserrat(fontSize: size,color: color,fontWeight: fw);
}


