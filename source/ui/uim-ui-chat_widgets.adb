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
with Qt4.H_Box_Layouts.Constructors;
with Qt4.List_Widgets.Constructors;
with Qt4.Splitters.Constructors;
with Qt4.Strings;
with Qt4.Text_Edits.Constructors;
with Qt4.V_Box_Layouts.Constructors;
with Qt4.Widgets.Directors;

with UIM.UI.Chat_Widgets.MOC;
pragma Warnings (Off, UIM.UI.Chat_Widgets.MOC);
--  Child package MOC must be included in the executable file.

package body UIM.UI.Chat_Widgets is

   use type Qt4.Strings.Q_String;

   -------------------
   --  Add_Message  --
   -------------------
   procedure Add_Message (Self : not null access Chat_Widget;
                          Msg  : UIM.Protocols.Messages.Message_Access) is
   begin
      Self.History_Widget.Append
        (Qt4.Strings.From_Ucs_4 ("<")
           & Msg.Get_Sender.Name
           & Qt4.Strings.From_Ucs_4 ("> ")
           & Qt4.Strings.From_Ucs_4 (Msg.Get_Body.To_Wide_Wide_String));
   end Add_Message;

   --------------
   --  Create  --
   --------------
   function Create (User : UIM.Protocols.Users.User_Access)
      return not null access Chat_Widget'Class
   is
      Self : constant Chat_Widget_Access := new Chat_Widget;

      HLayout : constant not null access Qt4.H_Box_Layouts.Q_H_BOX_Layout'Class
        := Qt4.H_Box_Layouts.Constructors.Create;

      VLayout : constant not null access Qt4.V_BOX_Layouts.Q_V_BOX_Layout'Class
        := Qt4.V_BOX_Layouts.Constructors.Create;

      --  Splitter : Qt4.Splitters.Q_Splitter_Access
      --    := Qt4.Splitters.Constructors.Create;
      --  XXX: QtAda segfault when pointed out orientation in constructor
      --  := Qt4.Splitters.Constructors.Create (Qt4.Horizontal);

   begin
      Qt4.Widgets.Directors.Constructors.Initialize (Self);

      Self.History_Widget := Qt4.Text_Edits.Constructors.Create;
      Self.Message_Edit := Qt4.Text_Edits.Constructors.Create;
      Self.Members := Qt4.List_Widgets.Constructors.Create;

      --  XXX: not yet implemented
      --  Splitter.Set_Orientation (Qt4.Horizontal);
      --  Splitter.Add_Widget (Self.History_Widget);
      --  Splitter.Add_Widget (Self.Message_Edit);

      VLayout.Add_Widget (Self.History_Widget);
      VLayout.Add_Widget (Self.Message_Edit);

      --  Self.Members.Set_Visible (False);
      HLayout.Add_Layout (VLayout);
      HLayout.Add_Widget (Self.Members);
      --  Splitter.Add_Widget (Self.Members);
      --  HLayout.Add_Widget (Splitter);

      Self.Set_Layout (HLayout);

      Self.Members.Add_Item (User.Name);

      Self.User := User;

      --  Self.History_Widget.Set_Read_Only (True);

      return Self;
   end Create;

   ----------------
   --  Get_User  --
   ----------------

   function Get_User (Self : not null access Chat_Widget)
      return UIM.Protocols.Users.User_Access is
   begin
      return Self.User;
   end Get_User;

end UIM.UI.Chat_Widgets;
