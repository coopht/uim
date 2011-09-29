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
with Qt4.Model_Indices;

with UIM.Protocols.Contact_List_Items;

package body UIM.Protocols.Contact_Lists is

   use Qt4;
   use type Qt4.Strings.Q_String;

   --  public API

   -----------------
   --  Add_Group  --
   -----------------

   procedure Add_Group
     (Self  : not null access Contact_List;
      Group : not null access UIM.Protocols.Groups.Group) is
   begin
      Self.Model.Add_Item (Child => Group);
   end Add_Group;

   ----------------
   --  Add_User  --
   ----------------

   procedure Add_User
     (Self  : not null access Contact_List;
      User  : not null access UIM.Protocols.Users.User;
      Group :          access UIM.Protocols.Groups.Group := null) is
   begin
      Self.Model.Add_Item (User);
   end Add_User;

   ----------------
   --  Add_User  --
   ----------------

   procedure Add_User
     (Self  : not null access Contact_List;
      User  : not null access UIM.Protocols.Users.User;
      Group : Qt4.Strings.Q_String) is
   begin
      for Row in 0 .. Self.Model.Row_Count (Qt4.Model_Indices.Create) - 1 loop
         declare
            Index : constant Qt4.Model_Indices.Q_Model_Index
              := Self.Model.Index (Row, 0, Qt4.Model_Indices.Create);

            Item : UIM.Protocols.Groups.Group_Access
              := UIM.Protocols.Groups.Group_Access
                  (Self.Model.To_Item (Index));

         begin
            if Group.Is_Empty then
               Item.Append_Child
                (UIM.Protocols.Contact_List_Items.Contact_List_Item_Access
                  (User));

            else
               if Item.Name = Group then
                  Item.Append_Child
                    (UIM.Protocols.Contact_List_Items.Contact_List_Item_Access
                      (User));
               end if;
            end if;
         end;
      end loop;
   end Add_User;

   -----------------
   --  Get_Model  --
   -----------------

   function Get_Model (Self  : not null access Contact_List)
      return
        not null access UIM.Protocols.Contact_List_Models.Contact_List_Model
   is
   begin
      return Self.Model;
   end Get_Model;

   --------------------
   --  Remove_Group  --
   --------------------
   procedure Remove_Group
     (Self  : not null access Contact_List;
      Group : not null access UIM.Protocols.Groups.Group) is
   begin
      null;
   end Remove_Group;

end UIM.Protocols.Contact_Lists;
