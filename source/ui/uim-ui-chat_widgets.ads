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
with Qt4.List_Widgets;
with Qt4.Push_Buttons;
with Qt4.Text_Edits;
with Qt4.Widgets;
private with Qt4.Widgets.Directors;

with UIM.Protocols.Messages;
with UIM.Protocols.Users;

package UIM.UI.Chat_Widgets is

   type Chat_Widget is limited new Qt4.Widgets.Q_Widget with private;

   type Chat_Widget_Access is access all Chat_Widget;

   function Create (User : UIM.Protocols.Users.User_Access)
      return not null access Chat_Widget'Class;

   function Get_User (Self : not null access Chat_Widget)
      return UIM.Protocols.Users.User_Access;
   --  Returns user assosiated with tab

   procedure Add_Message (Self : not null access Chat_Widget;
                          Msg  : UIM.Protocols.Messages.Message_Access);
   --  Adds new message to the history view

private

   type Chat_Widget is limited new Qt4.Widgets.Directors.Q_Widget_Director
     with record
     History_Widget : Qt4.Text_Edits.Q_Text_Edit_Access;
     Message_Edit   : Qt4.Text_Edits.Q_Text_Edit_Access;
     Members        : Qt4.List_Widgets.Q_List_Widget_Access;
     Send_Button    : Qt4.Push_Buttons.Q_Push_Button_Access;
     --  Owner of current dialog
     User           : UIM.Protocols.Users.User_Access := null;
   end record;

end UIM.UI.Chat_Widgets;
