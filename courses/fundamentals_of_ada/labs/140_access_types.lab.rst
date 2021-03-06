------------------
Access Types Lab
------------------

* Requirements

   - Create a datastore containing an array of records

      * Each record contains an array to store strings
      * Interface to the array consists *only* of functions that return an element of the array (Input parameter would be the array index)

   - Main program should allow the user to specify an index and a string

      + String gets appended to end of string pointer array
      + When data entry is complete, print only the elements of the array that have data

* Hints

   - Interface functions need to pass back pointer to array element

      + For safety, create a function to return a modifiable pointer and another to return a read-only pointer

   - Cannot create array of variable length strings, so use pointers

---------------------------------------
Access Types Lab Solution - Datastore
---------------------------------------

.. code:: Ada

   package Datastore is
     type String_Ptr_T is access String;
     type History_T is array (1 .. 10) of String_Ptr_T;
     type Element_T is tagged record
       History : History_T;
     end record;
     type Reference_T is access all Element_T;
     type Constant_Reference_T is access constant Element_T;

     subtype Index_T is Integer range 1 .. 100;
     function Object (Index : Index_T) return Reference_T;
     function View (Index : Index_T) return Constant_Reference_T;
   end Datastore;

   package body Datastore is
     type Array_T is array (Index_T) of aliased Element_T;
     Global_Data : aliased Array_T;

     function Object (Index : Index_T) return Reference_T is
       (Global_Data (Index)'Access);
     function View (Index : Index_T) return Constant_Reference_T is
       (Global_Data (Index)'Access);
   end Datastore;

----------------------------------
Access Types Lab Solution - Main
----------------------------------

.. code:: Ada

   with Ada.Text_IO; use Ada.Text_IO;
   with Datastore;   use Datastore;
   procedure Main is

     function Get (Prompt : String) return String is
     begin
       Put ("   " & Prompt & "> ");
       return Get_Line;
     end Get;

     procedure Add (History : in out Datastore.History_T;
                    Text    : in     String) is
     begin
       for Event of History loop
         if Event = null then
           Event := new String'(Text);
           exit;
         end if;
       end loop;
     end Add;

     Index  : Integer;
     Object : Datastore.Constant_Reference_T;

   begin

     loop
       Index := Integer'Value (Get ("Enter index"));
       exit when Index not in Datastore.Index_T'Range;
       Add (Datastore.Object (Index).History, Get ("Text"));

     end loop;

     for I in Index_T'Range loop
       Object := Datastore.View (I);
       if Object.History (1) /= null then
         Put_Line (Integer'Image (I) & ">");
         for Item of Object.History loop
           exit when Item = null;
           Put_Line ("  " & Item.all);
         end loop;
       end if;
     end loop;

   end Main;
