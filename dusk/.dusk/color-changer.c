/*
  Copyright 2021 Karl Ragnar Giese, karl@giese.no


  This file is part of Dusk.

  Dusk is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  Dusk is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Dusk; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/



char fg[8];
char bg[8];
char cursor[8];
char contrast[8];
char black1[8];
char black2[8];
char red1[8];
char red2[8];
char green1[8];
char green2[8];
char yellow1[8];
char yellow2[8];
char blue1[8];
char blue2[8];
char magenta1[8];
char magenta2[8];
char cyan1[8];
char cyan2[8];
char white1[8];
char white2[8];

// new colors
char rosewater[8];
char flamingo[8];
char pink[8];
char mauve[8];
char red[8];
char maroon[8];
char peach[8];
char yellow[8];
char green[8];
char teal[8];
char sky[8];
char sapphire[8];
char blue[8];
char lavender[8];
char text[8];
char subtext1[8];
char subtext0[8];
char overlay2[8];
char overlay1[8];
char overlay0[8];
char surface2[8];
char surface1[8];
char surface0[8];
char base[8];
char mantle[8];
char crust[8];

char emacstheme[64];
char dwmtextbg[8];
char dwmtextfg[8];
char dwmborder[8];
char dwmbordersel[8];
char dwmtagbg[8];
char dwmtagfg[8];
char dwmtagselbg[8];
char dwmtagselfg[8];
char dwmtitlebg[8];
char dwmtitlefg[8];
char dwmtitleselbg[8];
char dwmtitleselfg[8];
char gtktheme[64];

void applypywal(){
  FILE *pywalfile;
  char buffer[64];

  /* make JSON for pywal using cJSON */
  cJSON *pywalcjson = cJSON_CreateObject();

  cJSON_AddStringToObject(pywalcjson, "wallpaper", "None");
  cJSON_AddStringToObject(pywalcjson, "alpha", "100");

  cJSON *special = cJSON_AddObjectToObject(pywalcjson, "special");
  cJSON_AddStringToObject(special, "background", bg);
  cJSON_AddStringToObject(special, "foreground", fg);
  cJSON_AddStringToObject(special, "cursor", cursor);

  cJSON *colors = cJSON_AddObjectToObject(pywalcjson, "colors");
  cJSON_AddStringToObject(colors, "color0",  black1);
  cJSON_AddStringToObject(colors, "color1",  red1);
  cJSON_AddStringToObject(colors, "color2",  green1);
  cJSON_AddStringToObject(colors, "color3",  yellow1);
  cJSON_AddStringToObject(colors, "color4",  blue1);
  cJSON_AddStringToObject(colors, "color5",  magenta1);
  cJSON_AddStringToObject(colors, "color6",  cyan1);
  cJSON_AddStringToObject(colors, "color7",  white1);
  cJSON_AddStringToObject(colors, "color8",  black2);
  cJSON_AddStringToObject(colors, "color9",  red2);
  cJSON_AddStringToObject(colors, "color10", green2);
  cJSON_AddStringToObject(colors, "color11", yellow2);
  cJSON_AddStringToObject(colors, "color12", blue2);
  cJSON_AddStringToObject(colors, "color13", magenta2);
  cJSON_AddStringToObject(colors, "color14", cyan2);
  cJSON_AddStringToObject(colors, "color15", white2);

  // aditional catppuccin colors
  cJSON_AddStringToObject(colors, "color16", rosewater);
  cJSON_AddStringToObject(colors, "color17", flamingo);
  cJSON_AddStringToObject(colors, "color18", pink);
  cJSON_AddStringToObject(colors, "color19", mauve);
  cJSON_AddStringToObject(colors, "color20", red);
  cJSON_AddStringToObject(colors, "color21", maroon);
  cJSON_AddStringToObject(colors, "color22", peach);
  cJSON_AddStringToObject(colors, "color23", yellow);
  cJSON_AddStringToObject(colors, "color24", green);
  cJSON_AddStringToObject(colors, "color25", teal);
  cJSON_AddStringToObject(colors, "color26", sky);
  cJSON_AddStringToObject(colors, "color27", sapphire);
  cJSON_AddStringToObject(colors, "color28", blue);
  cJSON_AddStringToObject(colors, "color29", lavender);
  cJSON_AddStringToObject(colors, "color30", text);
  cJSON_AddStringToObject(colors, "color31", subtext1);
  cJSON_AddStringToObject(colors, "color32", subtext0);
  cJSON_AddStringToObject(colors, "color33", overlay2);
  cJSON_AddStringToObject(colors, "color34", overlay1);
  cJSON_AddStringToObject(colors, "color35", overlay0);
  cJSON_AddStringToObject(colors, "color36", surface2);
  cJSON_AddStringToObject(colors, "color37", surface1);
  cJSON_AddStringToObject(colors, "color38", surface0);
  cJSON_AddStringToObject(colors, "color39", base);
  cJSON_AddStringToObject(colors, "color40", mantle);
  cJSON_AddStringToObject(colors, "color41", crust);

  /* Write JSON */
  sprintf(buffer, "%s/.cache/dusk/pywal", getenv("HOME"));

  pywalfile=fopen(buffer, "w");
  fputs(cJSON_Print(pywalcjson), pywalfile);
  fclose(pywalfile);

  /* Load JSON to pywal */
  sprintf(buffer, "wal -q --theme %s/.cache/dusk/pywal", getenv("HOME"));
  system(buffer);

  cJSON_Delete(pywalcjson);
}

void applyemacs(){
  char buffer[256];
  sprintf(buffer, "emacsclient --eval \"  (progn (setq catppuccin-flavor '%s) (catppuccin-reload))\"", emacstheme);
  system(buffer);
}

void applydwm(){
  FILE *xresources;
  char buffer[512];

  sprintf(buffer, "%s/.cache/dusk/xresources", getenv("HOME"));
  xresources = fopen(buffer, "w");

  /* Make xresources for DWM */
  sprintf(buffer,
          "dwm.normbgcolor:        %s\n"
          "dwm.normfgcolor:        %s\n"
          "dwm.normbordercolor:    %s\n"
          "dwm.selbordercolor:     %s\n"
          "dwm.tagsnormbgcolor:    %s\n"
          "dwm.tagsnormfgcolor:    %s\n"
          "dwm.tagsselbgcolor:     %s\n"
          "dwm.tagsselfgcolor:     %s\n"
          "dwm.titlenormbgcolor:   %s\n"
          "dwm.titlenormfgcolor:   %s\n"
          "dwm.titleselbgcolor:    %s\n"
          "dwm.titleselfgcolor:    %s\n",
          dwmtextbg,
          dwmtextfg,
          dwmborder,
          dwmbordersel,
          dwmtagbg,
          dwmtagfg,
          dwmtagselbg,
          dwmtagselfg,
          dwmtitlebg,
          dwmtitlefg,
          dwmtitleselbg,
          dwmtitleselfg);

  fprintf(xresources, buffer);
  fclose(xresources);

  /* Apply xresources with the xrdb patch and hte dwmc patch */
  system("xrdb -merge ~/.cache/dusk/xresources");
  system("~/.dwm/patch/dwmc xrdb");

  /* Change x root window color */
  system("pkill bar.sh");
  system("~/.dwm/bar.sh &");

  /* Change alacritty and rofi themes */
  system("~/.config/alacritty/theme-patcher.sh &");
  system("~/.config/rofi/theme-patcher.sh &");
}

void applygtk(){
  char buffer[128];
  FILE *xsettings;

  sprintf(buffer, "%s/.xsettingsd", getenv("HOME"));
  xsettings = fopen(buffer, "w");
  fprintf(xsettings, "Net/ThemeName \"%s\"", gtktheme);
  fclose(xsettings);
  system("killall -HUP xsettingsd");
}

void changescheme(int color){
  char buffer[256];

  /* make sure ~/.cache/dusk exists */
  sprintf(buffer, "%s/.cache/dusk", getenv("HOME"));
  mkdir(buffer, 0755);

  /* Select colors from the macros in config.h depending on the color scheme */
  switch (color) {
  case 1: {
    /* light mode */
    strcpy(fg, LTEXT);
    strcpy(bg, LBASE);
    strcpy(cursor, LTEXT);
    strcpy(contrast, LGREEN);
    
    strcpy(black1, LCRUST);
    strcpy(black2, LCRUST);
    strcpy(red1, LRED);
    strcpy(red2, LRED);
    strcpy(green1, LGREEN);
    strcpy(green2, LGREEN);
    strcpy(yellow1, LYELLOW);
    strcpy(yellow2, LYELLOW);
    strcpy(blue1, LBLUE);
    strcpy(blue2, LBLUE);
    strcpy(magenta1, LPINK);
    strcpy(magenta2, LPINK);
    strcpy(cyan1, LTEAL);
    strcpy(cyan2, LTEAL);
    strcpy(white1, LTEXT);
    strcpy(white2, LTEXT);

    /* Colors */
    strcpy(rosewater, LROSEWATER);
    strcpy(flamingo, LFLAMINGO);
    strcpy(pink, LPINK);
    strcpy(mauve, LMAUVE);
    strcpy(red, LRED);
    strcpy(maroon, LMAROON);
    strcpy(peach, LPEACH);
    strcpy(yellow, LYELLOW);
    strcpy(green, LGREEN);
    strcpy(teal, LTEAL);
    strcpy(sky, LSKY);
    strcpy(sapphire, LSAPPHIRE);
    strcpy(blue, LBLUE);
    strcpy(lavender, LLAVENDER);

    /* Text and subtext colors */
    strcpy(text, LTEXT);
    strcpy(subtext1, LSUBTEXT1);
    strcpy(subtext0, LSUBTEXT0);

    /* Overlay colors */
    strcpy(overlay2, LOVERLAY2);
    strcpy(overlay1, LOVERLAY1);
    strcpy(overlay0, LOVERLAY0);

    /* Surface colors */
    strcpy(surface2, LSURFACE2);
    strcpy(surface1, LSURFACE1);
    strcpy(surface0, LSURFACE0);

    /* Base, mantle, and crust colors */
    strcpy(base, LBASE);
    strcpy(mantle, LMANTLE);
    strcpy(crust, LCRUST);

    strcpy(emacstheme, LEMACS);
    strcpy(dwmtextbg, LDWMTEXTBG);
    strcpy(dwmtextfg, LDWMTEXTFG);
    strcpy(dwmborder, LDWMBORDER);
    strcpy(dwmbordersel, LDWMBORDERSEL);
    strcpy(dwmtagbg, LDWMTAGBG);
    strcpy(dwmtagfg, LDWMTAGFG);
    strcpy(dwmtagselbg, LDWMTAGSELBG);
    strcpy(dwmtagselfg, LDWMTAGSELFG);
    strcpy(dwmtitlebg, LDWMTITLEBG);
    strcpy(dwmtitlefg, LDWMTITLEFG);
    strcpy(dwmtitleselbg, LDWMTITLESELBG);
    strcpy(dwmtitleselfg, LDWMTITLESELFG);
    strcpy(gtktheme, LGTKTHEME);
    printf("%s\n", "light mode");
    break;
  }
  case 0: {
    /* dark mode */
    strcpy(fg, DTEXT);
    strcpy(bg, DBASE);
    strcpy(cursor, DTEXT);
    strcpy(contrast, DBLUE);
    strcpy(black1, DCRUST);
    strcpy(black2, DCRUST);
    strcpy(red1, DRED);
    strcpy(red2, DRED);
    strcpy(green1, DGREEN);
    strcpy(green2, DGREEN);
    strcpy(yellow1, DYELLOW);
    strcpy(yellow2, DYELLOW);
    strcpy(blue1, DBLUE);
    strcpy(blue2, DBLUE);
    strcpy(magenta1, DPINK);
    strcpy(magenta2, DPINK);
    strcpy(cyan1, DTEAL);
    strcpy(cyan2, DTEAL);
    strcpy(white1, DTEXT);
    strcpy(white2, DTEXT);

    /* Colors */
    strcpy(rosewater, DROSEWATER);
    strcpy(flamingo, DFLAMINGO);
    strcpy(pink, DPINK);
    strcpy(mauve, DMAUVE);
    strcpy(red, DRED);
    strcpy(maroon, DMAROON);
    strcpy(peach, DPEACH);
    strcpy(yellow, DYELLOW);
    strcpy(green, DGREEN);
    strcpy(teal, DTEAL);
    strcpy(sky, DSKY);
    strcpy(sapphire, DSAPPHIRE);
    strcpy(blue, DBLUE);
    strcpy(lavender, DLAVENDER);

    /* Text and subtext colors */
    strcpy(text, DTEXT);
    strcpy(subtext1, DSUBTEXT1);
    strcpy(subtext0, DSUBTEXT0);

    /* Overlay colors */
    strcpy(overlay2, DOVERLAY2);
    strcpy(overlay1, DOVERLAY1);
    strcpy(overlay0, DOVERLAY0);

    /* Surface colors */
    strcpy(surface2, DSURFACE2);
    strcpy(surface1, DSURFACE1);
    strcpy(surface0, DSURFACE0);

    /* Base, mantle, and crust colors */
    strcpy(base, DBASE);
    strcpy(mantle, DMANTLE);
    strcpy(crust, DCRUST);

    strcpy(emacstheme, DEMACS);
    strcpy(dwmtextbg, DDWMTEXTBG);
    strcpy(dwmtextfg, DDWMTEXTFG);
    strcpy(dwmborder, DDWMBORDER);
    strcpy(dwmbordersel, DDWMBORDERSEL);
    strcpy(dwmtagbg, DDWMTAGBG);
    strcpy(dwmtagfg, DDWMTAGFG);
    strcpy(dwmtagselbg, DDWMTAGSELBG);
    strcpy(dwmtagselfg, DDWMTAGSELFG);
    strcpy(dwmtitlebg, DDWMTITLEBG);
    strcpy(dwmtitlefg, DDWMTITLEFG);
    strcpy(dwmtitleselbg, DDWMTITLESELBG);
    strcpy(dwmtitleselfg, DDWMTITLESELFG);
    strcpy(gtktheme, DGTKTHEME);
    printf("%s\n", "dark mode");
    break;
  }
  default:
    fprintf(stderr, "color may only be 0 or 1");
    break;
  }

  /* Apply colors when macros are set in config.h */
  if (PYWAL) {
    applypywal();
  }

  if (EMACS) {
    applyemacs();
  }

  if (DWM) {
    applydwm();
  }

  if (GTK) {
    applygtk();
  }
}
