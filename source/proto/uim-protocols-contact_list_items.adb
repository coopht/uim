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
--  * Neither the name of the Alexander Basov, IE nor the names of its      --
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
with Qt4.Abstract_Item_Models;
with Qt4.Model_Indices;
with Qt4.Variants;
private with Qt4.Abstract_Item_Models.Directors;

package body UIM.Protocols.Contact_List_Items is

   --------------------
   --  Append_Child  --
   --------------------

   procedure Append_Child (Self  : in out Contact_List_Item;
                           Child : Contact_List_Item_Access) is
   begin
      Self.Children.Append (Child);
   end Append_Child;

   ----------------
   --  Child_At  --
   ----------------

   function Child_At (Self : Contact_List_Item; Pos : Qt4.Q_Integer)
     return Contact_List_Item_Access is
   begin
      return Self.Children.Element (Integer (Pos));
   end Child_At;

   ----------------
   --  Children  --
   ----------------

   function Children (Self : Contact_List_Item)
      return Contact_List_Item_Vectors.Vector is
   begin
      return Self.Children;
   end Children;

   -----------------------
   --  Children_Length  --
   -----------------------

   function Children_Length (Self : Contact_List_Item) return Qt4.Q_Integer is
   begin
      return Qt4.Q_Integer (Self.Children.Length);
   end Children_Length;

   --------------------
   --  Column_Count  --
   --------------------

   function Column_Count (Self : Contact_List_Item)
      return Qt4.Q_Integer is
      pragma Unreferenced (Self);

   begin
      return 1;
   end Column_Count;

   ------------
   -- Data --
   ------------
   function Data (Self : Contact_List_Item; Column : Qt4.Q_Integer)
      return Qt4.Variants.Q_Variant is
      pragma Unreferenced (Column);

   begin
      return Qt4.Variants.Create (Self.Name);
   end Data;

   ------------------
   --  Find_Child  --
   ------------------

   function Find_Child (Self : Contact_List_Item;
                        Item : Contact_List_Item_Access)
      return Qt4.Q_Integer is
   begin
      return Qt4.Q_Integer (Self.Children.Find_Index (Item));
   end Find_Child;

   ------------
   --  Name  --
   ------------

   function Name (Self : Contact_List_Item) return Qt4.Strings.Q_String is
   begin
      return Self.Name;
   end Name;

   --------------
   --  Parent  --
   --------------

   function Parent (Self : Contact_List_Item) return Contact_List_Item_Access
   is
   begin
      return Self.Parent;
   end Parent;

   -----------
   -- Row --
   -----------
   function Row (Self : not null access Contact_List_Item)
      return Qt4.Q_Integer is
   begin
      if Self.Parent /= null then
         return
           Qt4.Q_Integer
            (Self.Parent.Children.Find_Index
              (Contact_List_Item_Access (Self)));
      else
         return 0;
      end if;
   end Row;

   ----------------
   --  Set_Name  --
   ----------------

   procedure Set_Name (Self : in out Contact_List_Item;
                       Name : Qt4.Strings.Q_String) is
   begin
      Self.Name := Name;
   end Set_Name;

end UIM.Protocols.Contact_List_Items;
