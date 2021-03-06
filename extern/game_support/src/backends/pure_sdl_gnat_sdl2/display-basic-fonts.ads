with Display.Basic.Utils; use Display.Basic.Utils;
with SDL_stdinc_h; use SDL_stdinc_h;
with SDL_surface_h; use SDL_surface_h;

package Display.Basic.Fonts is

   type BMP_Font is (Font8x8, Font12x12, Font16x24);

   procedure Draw_Char
     (S : access SDL_Surface;
      P : Screen_Point;
      Char   : Character;
      Font   : BMP_Font;
      FG, BG : Uint32);

   procedure Draw_Char
     (Canvas : T_Internal_Canvas;
      P : Screen_Point;
      Char   : Character;
      Font   : BMP_Font;
      FG, BG : Uint32);

   procedure Draw_String
     (S : access SDL_Surface;
      P : Screen_Point;
      Str    : String;
      Font   : BMP_Font;
      FG, BG : RGBA_T;
      Wrap   : Boolean := False);

   procedure Draw_String
     (Canvas : T_Internal_Canvas;
      P : Screen_Point;
      Str    : String;
      Font   : BMP_Font;
      FG, BG : RGBA_T;
      Wrap   : Boolean := False);

   function Char_Size (Font : BMP_Font) return Screen_Point;

   function String_Size (Font : BMP_Font; Text : String) return Screen_Point;

end Display.Basic.Fonts;
