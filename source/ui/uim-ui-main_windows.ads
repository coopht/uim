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
with Qt4.Close_Events;
with Qt4.Main_Windows;
with Qt4.Menus;
private with Qt4.Main_Windows.Directors;
with Qt4.Tab_Widgets;
with Qt4.Variants;

with UIM.UI.Chat_Windows;

package UIM.UI.Main_Windows is

   type Main_Window is limited new Qt4.Main_Windows.Q_Main_Window with private;

   type Main_Window_Access is access all Main_Window'Class;

   function Create return not null Main_Window_Access;

private

   type Main_Window is
      limited new Qt4.Main_Windows.Directors.Q_Main_Window_Director with record
        Central_Widget : Qt4.Tab_Widgets.Q_Tab_Widget_Access;
        Main_Menu      : Qt4.Menus.Q_Menu_Access;

        --  Menu Actions
        Add_User_Act     : Qt4.Actions.Q_Action_Access;
        Add_Group_Act    : Qt4.Actions.Q_Action_Access;
        Find_Contact_Act : Qt4.Actions.Q_Action_Access;
        Hide_Window_Act  : Qt4.Actions.Q_Action_Access;
        Quit_Act         : Qt4.Actions.Q_Action_Access;
        Settings_Act     : Qt4.Actions.Q_Action_Access;
        User_Info_Act    : Qt4.Actions.Q_Action_Access;
        Join_Chat_Act    : Qt4.Actions.Q_Action_Access;

        --  Different windows, independent from any proto
        Chat_Window      : UIM.UI.Chat_Windows.Chat_Window_Access := null;
   end record;

   procedure Create_Actions (Self : not null access Main_Window'Class);

   procedure Create_Main_Menu (Self : not null access Main_Window'Class);

   --  Slots

   --  Shows user info about selected user in Contact List
   procedure Show_User_Info (Self  : not null access Main_Window);
   pragma Q_Slot (Show_User_Info);

   procedure Show_Settings_Slot (Self : not null access Main_Window);
   pragma Q_Slot (Show_Settings_Slot);

   procedure Add_Group_Slot (Self : not null access Main_Window);
   pragma Q_Slot (Add_Group_Slot);

   procedure Add_User_Slot (Self : not null access Main_Window);
   pragma Q_Slot (Add_User_Slot);

   procedure Find_Contact_Slot (Self  : not null access Main_Window);
   pragma Q_Slot (Find_Contact_Slot);

   procedure Save_Settings_Slot (Self  : not null access Main_Window);
   pragma Q_Slot (Save_Settings_Slot);

   procedure Load_Settings_Slot (Self  : not null access Main_Window);
   pragma Q_Slot (Load_Settings_Slot);

   procedure Join_Chat_Slot (Self  : not null access Main_Window);
   pragma Q_Slot (Join_Chat_Slot);

   procedure New_Msg_Slot (Self : not null access Main_Window;
                           Msg  : Qt4.Variants.Q_Variant);
   pragma Q_Slot (New_Msg_Slot, "newMsgSlot(QVariant)");

   procedure Typing_Message_Slot (Self : not null access Main_Window;
                                  User : Qt4.Variants.Q_Variant);
   pragma Q_Slot (Typing_Message_Slot, "typingMessageSlot(QVariant)");

   --  Events
   procedure Close_Event
     (Self  : not null access Main_Window;
      Event : not null access Qt4.Close_Events.Q_Close_Event'Class);

end UIM.UI.Main_Windows;
