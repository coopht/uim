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
with Qt4.Strings;

with Qt4.Objects;
private with Qt4.Objects.Directors;

with UIM.Protocols.Contact_List_Models;
with UIM.Protocols.Groups;
with UIM.Protocols.Users;

package UIM.Protocols.Contact_Lists is

   type Contact_List is limited new Qt4.Objects.Q_Object with private;

   type Contact_List_Access is access all Contact_List;

   --  public API

   procedure Add_User
     (Self  : not null access Contact_List;
      User  : not null access UIM.Protocols.Users.User;
      Group :          access UIM.Protocols.Groups.Group := null);
   --  Add user to group from contact list.
   --  if group does not exists, or it does not specified, user added to
   --  contact list without group

   procedure Add_User
     (Self  : not null access Contact_List;
      User  : not null access UIM.Protocols.Users.User;
      Group : Qt4.Strings.Q_String);
   --  Add user to group with Group_ID from contact list.
   --  if group does not exists, or it does not specified, user added to
   --  contact list without group

   procedure Add_Group
     (Self  : not null access Contact_List;
      Group : not null access UIM.Protocols.Groups.Group);
   --  Add new group to contact list

   procedure Remove_Group
     (Self  : not null access Contact_List;
      Group : not null access UIM.Protocols.Groups.Group);
   --  Remove group from contact list

   function Get_Model (Self  : not null access Contact_List)
      return
        not null access UIM.Protocols.Contact_List_Models.Contact_List_Model;

private

   type Contact_List is limited new Qt4.Objects.Directors.Q_Object_Director
     with record
        Show_Offline_Contacts : Boolean := False;
        Show_Empty_Groups : Boolean := False;
        Show_Groups : Boolean := False;

        Model : UIM.Protocols.Contact_List_Models.Contact_List_Model_Access
          := UIM.Protocols.Contact_List_Models.Create;
   end record;

end UIM.Protocols.Contact_Lists;
