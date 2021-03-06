-----------------------------------------------------------------------
--                              Ada Labs                             --
--                                                                   --
--                 Copyright (C) 2008-2009, AdaCore                  --
--                                                                   --
-- Labs is free  software; you can redistribute it and/or modify  it --
-- under the terms of the GNU General Public License as published by --
-- the Free Software Foundation; either version 2 of the License, or --
-- (at your option) any later version.                               --
--                                                                   --
-- This program is  distributed in the hope that it will be  useful, --
-- but  WITHOUT ANY WARRANTY;  without even the  implied warranty of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details. You should have received --
-- a copy of the GNU General Public License along with this program; --
-- if not,  write to the  Free Software Foundation, Inc.,  59 Temple --
-- Place - Suite 330, Boston, MA 02111-1307, USA.                    --
-----------------------------------------------------------------------

with Display;       use Display;
with Display.Basic; use Display.Basic;

package Solar_System is

   --  define type Bodies_Enum as an enumeration of Sun, Earth, Moon, Satellite
   type Bodies_Enum is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);

   procedure Init_Body
     (B            : Bodies_Enum;
      Radius       : Float;
      Color        : RGBA_T;
      Distance     : Float;
      Speed        : Float;
      Turns_Around : Bodies_Enum;
      Angle        : Float   := 0.0;
      Tail         : Boolean := False;
      Visible      : Boolean := True);

private

   type Position is record
      X : Float := 0.0;
      Y : Float := 0.0;
   end record;

   type Tail_Length is new Integer range 1 .. 10;
   type T_Tail is array (Tail_Length) of Position;

   type Body_Type is record
      Pos          : Position;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Radius       : Float;
      Color        : RGBA_T;
      Visible      : Boolean := True;
      Turns_Around : Bodies_Enum;
      With_Tail    : Boolean := False;
      Tail         : T_Tail  := (others => (0.0, 0.0));
   end record;

   protected Dispatch_Tasks is
      procedure Get_Next_Body (B : out Bodies_Enum);
   private
      Current : Bodies_Enum := Bodies_Enum'First;
   end Dispatch_Tasks;

   task type T_Move_Body;

   type Task_Array is array (Bodies_Enum) of T_Move_Body;
   Tasks : Task_Array;

   protected type P_Body is
      function Get_Data return Body_Type;
      procedure Set_Data (B : Body_Type);
   private
      Data : Body_Type;
   end P_Body;

   type Bodies_Array is array (Bodies_Enum) of P_Body;
   Bodies : Bodies_Array;

   procedure Move (Body_To_Move : in out Body_Type; Turns_Around : Body_Type);

end Solar_System;
