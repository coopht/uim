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
with Qt4.Strings;

with UIM.Protocols.Contact_List_Models.MOC;
pragma Warnings (Off, UIM.Protocols.Contact_List_Models.MOC);
--  Child package MOC must be included in the executable file.

package body UIM.Protocols.Contact_List_Models is

   use Qt4;

   package Convert is
      new System.Address_To_Access_Conversions
           (UIM.Protocols.Contact_List_Items.Contact_List_Item);

   ----------------
   --  Add_Item  --
   ----------------

   procedure Add_Item
    (Self   : not null access Contact_List_Model;
     Child  : not null access Contact_List_Item'Class;
     Parent :          access Contact_List_Item'Class := null) is

      Item : Contact_List_Item_Access;
      Idx : Qt4.Model_Indices.Q_Model_Index;

   begin
      if Parent /= null then
         Idx := Self.Index (Parent.Row);
      else
         Idx := Qt4.Model_Indices.Create;
      end if;

      if Idx.Is_Valid then
         Item := Self.To_Item (Idx);

         if Item = null then
            Item := Self.Root;
         end if;

      else
         Item := Self.Root;
      end if;

      --  Inserting one row to the end;
      Self.Begin_Insert_Rows (Idx, Self.Row_Count (Idx), Self.Row_Count (Idx));

      Item.Append_Child (Contact_List_Item_Access (Child));

      Self.End_Insert_Rows;
   end Add_Item;

   --------------------
   --  Column_Count  --
   --------------------
   overriding function Column_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Q_Integer is
   begin
      if Parent.Is_Valid then
         return Self.To_Item (Parent).Column_Count;
      else
         return Self.Root.Column_Count;
      end if;
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

      Self.Root := new UIM.Protocols.Contact_List_Items.Contact_List_Item (0);
      Self.Root.Set_Name (Qt4.Strings.From_Utf_16 ("Root_Item"));
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
         return Item.Data (Index.Column);
      end if;

      return Qt4.Variants.Create;
   end Data;

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
      return Qt4.Variants.Create (Qt4.Strings.From_Utf_16 ("xxx"));
   end Header_Data;

   -------------
   --  Index  --
   -------------
   overriding function Index
    (Self   : not null access constant Contact_List_Model;
     Row    : Qt4.Q_Integer;
     Column : Qt4.Q_Integer := 0;
     Parent : Qt4.Model_Indices.Q_Model_Index := Qt4.Model_Indices.Create)
       return Qt4.Model_Indices.Q_Model_Index is

      Parent_Item : Contact_List_Item_Access;
      Child_Item  : Contact_List_Item_Access;

   begin
      if not Parent.Is_Valid then
         Parent_Item := Self.Root;

      else
         Parent_Item := Self.To_Item (Parent);
      end if;

      Child_Item := Parent_Item.Child_At (Row);

      if Child_Item /= null then
         return Self.Create_Index (Row,
                                   Column,
                                   Convert.To_Address
                                     (Convert.Object_Pointer (Child_Item)));
      else
         return Qt4.Model_Indices.Create;
      end if;
   end Index;

   --------------
   --  Parent  --
   --------------
   overriding function Parent
    (Self  : not null access constant Contact_List_Model;
     Child : Qt4.Model_Indices.Q_Model_Index)
                 return Qt4.Model_Indices.Q_Model_Index is

      Child_Item  : Contact_List_Item_Access;
      Parent_Item : Contact_List_Item_Access;

   begin
      if not Child.Is_Valid then
         return Qt4.Model_Indices.Create;
      end if;

      Child_Item := Self.To_Item (Child);
      Parent_Item := Child_Item.Parent;

      if Parent_Item = null then
         return Qt4.Model_Indices.Create;
      end if;

      if Parent_Item = Self.Root then
         return Qt4.Model_Indices.Create;
      end if;

      return Self.Create_Index (Q_Integer (Parent_Item.Row),
                                0,
                                Convert.To_Address
                                  (Convert.Object_Pointer (Parent_Item)));
   end Parent;

   -----------------
   --  Row_Count  --
   -----------------
   overriding function Row_Count
    (Self   : not null access constant Contact_List_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index)
        return Qt4.Q_Integer is
      Parent_Item : Contact_List_Item_Access;

   begin
      --  if Parent.Column > 0 then
      --     return 0;
      --  end if;

      if not Parent.Is_Valid then
         Parent_Item := Self.Root;
      else
         Parent_Item := Self.To_Item (Parent);
      end if;

      return Q_Integer (Parent_Item.Children_Length);
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
