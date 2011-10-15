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
with Qt4.Actions;
with Qt4.Main_Windows;
with Qt4.Menus;
with Qt4.Widgets;
private with Qt4.Main_Windows.Directors;
with Qt4.Tab_Widgets;

with UIM.Protocols.Messages;
with UIM.Protocols.Users;

with UIM.UI.Chat_Widgets;

with UIM.Utils.Logger;

package UIM.UI.Chat_Windows is

   type Chat_Window is limited new Qt4.Main_Windows.Q_Main_Window with private;

   type Chat_Window_Access is access all Chat_Window'Class;

   function Create return not null Chat_Window_Access;

   procedure Add_Dialog (Self    : not null access Chat_Window;
                         Message : UIM.Protocols.Messages.Message_Access);

   function Find_Tab_By_User (Self : not null access Chat_Window;
                              User : UIM.Protocols.Users.User_Access)
      return access UIM.UI.Chat_Widgets.Chat_Widget'Class;

private

   type Chat_Window is
      limited new Qt4.Main_Windows.Directors.Q_Main_Window_Director with record
        Central_Widget : Qt4.Tab_Widgets.Q_Tab_Widget_Access;
        Main_Menu      : Qt4.Menus.Q_Menu_Access;
        Quit_Act       : Qt4.Actions.Q_Action_Access;
        User_Info_Act  : Qt4.Actions.Q_Action_Access;
        Logger         : Utils.Logger.UIM_Logger;
   end record;

end UIM.UI.Chat_Windows;
