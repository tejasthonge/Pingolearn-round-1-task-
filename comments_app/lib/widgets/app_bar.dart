

import 'package:comments_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustumAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool havBackground;
   const CustumAppBar({super.key , required this.havBackground});

  @override
  AppBar build(BuildContext context) {
    return AppBar( 
        backgroundColor:
        havBackground?
          AppColor.blue :
         Colors.transparent,
        title: Text("Comments",
          style: GoogleFonts.poppins( 
            fontWeight: FontWeight.bold,
            color: havBackground?

            Colors.white :
            
              AppColor.blue,
          )
        ));
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(kToolbarHeight);
}