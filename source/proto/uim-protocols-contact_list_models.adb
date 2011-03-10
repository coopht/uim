------------------------------------------------------------------------------
--                                                                          --
--                               UIM Project                                --
--                                                                          --
--                Multi protocol instant messenger for unix                 --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Alexander Basov <coopht@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Alexander Basov, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with System.Address_To_Access_Conversions;

package body UIM.Protocols.Contact_List_Models is

   use UIM.Protocols.Contact_List_Items;
   use Qt4;

   package Convert is
      new System.Address_To_Access_Conversions
           (UIM.Protocols.Contact_List_Items.Contact_List_Item);

   --------------------
   --  Column_Count  --
   --------------------
   overriding function Column_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Q_Integer is
   begin
      return 1;
   end Column_Count;

   --------------
   --  Create  --
   --------------
   function Create return Contact_List_Model_Access
   is
      Self : constant not null Contact_List_Model_Access
        := new Contact_List_Model;

   begin
      Qt4.Abstract_Item_Models.Directors.Constructors.Initialize (Self);

      return Self;
   end Create;

   ------------
   --  Data  --
   ------------
   overriding function Data
    (Self  : not null access Contact_List_Model;
     Index : Qt4.Model_Indices.Q_Model_Index;
     Role  : Qt4.Item_Data_Role)
       return Qt4.Variants.Q_Variant is

      Item : Contact_List_Item_Access
        := Self.To_Item (Index);

   begin
      if Role = Qt4.Display_Role then
         case Index.Column is
            when 0 =>
               return Qt4.Variants.Create (Item.Name);

            when others =>
               return Qt4.Variants.Create;

         end case;
      end if;

      return Qt4.Variants.Create;
   end Data;

   --------------------
   --  Has_Children  --
   --------------------
   overriding function Has_Children
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Boolean is
   begin
      return False;
   end Has_Children;

   -------------------
   --  Header_Data  --
   -------------------
   overriding function Header_Data
    (Self        : not null access Contact_List_Model;
     Section     : Qt4.Q_Integer;
     Orientation : Qt4.Orientations;
     Role        : Qt4.Item_Data_Role)
       return Qt4.Variants.Q_Variant is
   begin
      return Qt4.Variants.Create;
   end Header_Data;

   -------------
   --  Index  --
   -------------
   overriding function Index
    (Self   : not null access constant Contact_List_Model;
     Row    : Qt4.Q_Integer;
     Column : Qt4.Q_Integer;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Model_Indices.Q_Model_Index is

      Parent_Item : constant Contact_List_Item_Access := Self.To_Item (Parent);

   begin
      if Parent.Is_Valid and then Parent.Column /= 0 then
         return Qt4.Model_Indices.Create;

      else
         return
           Self.Create_Index
            (Row,
             Column,
             Convert.To_Address
              (Convert.Object_Pointer
                (Parent_Item.Child_At (Row + 1))));
      end if;
   end Index;

   --------------
   --  Parent  --
   --------------
   overriding function Parent
    (Self  : not null access constant Contact_List_Model;
     Child : Qt4.Model_Indices.Q_Model_Index)
                 return Qt4.Model_Indices.Q_Model_Index is

      Child_Item : constant Contact_List_Item_Access := Self.To_Item (Child);

   begin
      if Child_Item.Parent = null
        or else Child_Item.Parent.Parent = null
      then
         return Qt4.Model_Indices.Create;

      else
         return
           Self.Create_Index
            ((Child_Item.Parent.Parent.Find_Child (Child_Item.Parent) - 1),
             0,
             Convert.To_Address (Convert.Object_Pointer (Child_Item.Parent)));
      end if;
   end Parent;

   -----------------
   --  Row_Count  --
   -----------------
   overriding function Row_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Q_Integer is

      Parent_Item : constant Contact_List_Item_Access := Self.To_Item (Parent);

   begin
      if Parent.Is_Valid and Parent.Column /= 0 then
         return 0;

      else
         return Parent_Item.Children_Length;
      end if;
   end Row_Count;

   ---------------
   --  To_Item  --
   ---------------
   function To_Item
    (Self  : not null access constant Contact_List_Model'Class;
     Index : Qt4.Model_Indices.Q_Model_Index)
       return Contact_List_Item_Access is
   begin
      if not Index.Is_Valid then
         return Self.Root;

      else
         return Contact_List_Item_Access
                 (Convert.To_Pointer (Index.Internal_Pointer));
      end if;
   end To_Item;

end UIM.Protocols.Contact_List_Models;