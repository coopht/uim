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

with Qt4.Actions.Constructors;
with Qt4.Core_Applications;
with Qt4.Key_Sequences;
with Qt4.Menus;
with Qt4.Menu_Bars;
with Qt4.Objects;
with Qt4.Strings;
with Qt4.Tab_Widgets.Constructors;

with UIM.Protocols.Registry;

with UIM.UI.Main_Windows.MOC;
pragma Warnings (Off, UIM.UI.Main_Windows.MOC);
--  Child package MOC must be included in the executable file.

with UIM.UI.Proto_Widgets;

package body UIM.UI.Main_Windows is

   use Qt4;

   ----------------------
   --  Add_Group_Slot  --
   ----------------------

   procedure Add_Group_Slot (Self : not null access Main_Window) is
      --  W  : constant not null access UIM.UI.Main_Widgets.Main_Widget'Class
      --    := UIM.UI.Main_Widgets.Main_Widget'Class
      --        (Self.Cent_Widget.Current_Widget.all)'Access;

      --  d_Dialog : constant UIM.UI.Add_Group_Dialogs.Add_Group_Dialog_Access
      --    := UIM.UI.Add_Group_Dialogs.Create (null, W.Get_Proto);

   begin
      null;
      --  Add_Dialog.Show;
   end Add_Group_Slot;

   ---------------------
   --  Add_User_Slot  --
   ---------------------
   procedure Add_User_Slot (Self : not null access Main_Window) is
      --  W  : constant not null access UIM.UI.Main_Widgets.Main_Widget'Class
      --    := UIM.UI.Main_Widgets.Main_Widget'Class
      --        (Self.Cent_Widget.Current_Widget.all)'Access;

      --  Add_Dialog : constant UIM.UI.Add_User_Dialogs.Add_User_Dialog_Access
      --    := UIM.UI.Add_User_Dialogs.Create (null, W.Get_Proto);

   begin
      --  Add_Dialog.Show;
      null;

   end Add_User_Slot;

   -------------------
   --  Close_Event  --
   -------------------

   procedure Close_Event
     (Self  : not null access Main_Window;
      Event : not null access Qt4.Close_Events.Q_Close_Event'Class) is
      pragma Unreferenced (Event);

   begin
      Self.Save_Settings_Slot;
   end Close_Event;

   --------------
   --  Create  --
   --------------

   function Create return not null Main_Window_Access is
      Self   : constant Main_Window_Access := new Main_Window;

      Tab_Id : Q_Integer;
      pragma Warnings (Off, Tab_Id);

   begin
      --  Initialize director
      Qt4.Main_Windows.Directors.Constructors.Initialize (Self);

      --  Create main_window central widget
      Self.Central_Widget := Qt4.Tab_Widgets.Constructors.Create;
      Self.Central_Widget.Set_Tab_Position (Qt4.Tab_Widgets.East);

      for J in 0 .. UIM.Protocols.Registry.Size - 1 loop

         Tab_Id :=
           Self.Central_Widget.Add_Tab
           (UIM.UI.Proto_Widgets.Create (UIM.Protocols.Registry.Item (J)),
            Qt4.Strings.From_Ucs_4
             (UIM.Protocols.Registry.Item (J).Get_Name.To_Wide_Wide_String));
      end loop;

      Self.Set_Central_Widget (Self.Central_Widget);
      Self.Set_Window_Title
        (Qt4.Strings.From_Ucs_4 ("Unix Instant Messenger"));

      Self.Create_Actions;
      Self.Create_Main_Menu;

      return Self;
   end Create;

   ----------------------
   --  Create_Actions  --
   ----------------------
   procedure Create_Actions (Self : not null access Main_Window'Class) is
   begin
      --  Settings Actions
      --  Add_Group_Act
      --  Add_Contact_Act

      --  Settings Actions
      Self.Join_Chat_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&Join Chat"), Self);
      Self.Join_Chat_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+J")));

      --  Add group action
      Self.Add_Group_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("Add &Group"), Self);
      Self.Add_Group_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+G")));

      --  Add Contact Action
      Self.Add_User_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("Add &User"), Self);
      Self.Add_User_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+C")));

      --  Find Contact action
      Self.Find_Contact_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&Find Contact"), Self);
      Self.Find_Contact_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+F")));

      --  User Info action
      Self.User_Info_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&User's Info"), Self);
      Self.User_Info_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+I")));

      --  Settings Actions
      Self.Settings_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&Settings"), Self);
      Self.Settings_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Alt+P")));

      --  Hide Window Actions
      Self.Hide_Window_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&Hide"), Self);

      --  Quit Window Actions
      Self.Quit_Act := Qt4.Actions.Constructors.Create
        (Qt4.Strings.From_Ucs_4 ("&Quit"), Self);
      Self.Quit_Act.Set_Shortcut
        (Qt4.Key_Sequences.Create (Qt4.Strings.From_Ucs_4 ("Ctrl+Q")));

      --  Connecting signals and slots
      Qt4.Objects.Connect (Self.Quit_Act,
                           Qt4.Signal ("triggered()"),
                           Qt4.Core_Applications.Instance,
                           Qt4.Slot ("quit()"));

      Qt4.Objects.Connect (Self.User_Info_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("showUserInfo()"));

      Qt4.Objects.Connect (Self.Find_Contact_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("findContactSlot()"));

      Qt4.Objects.Connect (Self.Settings_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("showSettingsSlot()"));

      Qt4.Objects.Connect (Self.Add_Group_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("addGroupSlot()"));

      Qt4.Objects.Connect (Self.Add_User_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("addUserSlot()"));

      Qt4.Objects.Connect (Self.Join_Chat_Act,
                           Qt4.Signal ("triggered()"),
                           Self,
                           Qt4.Slot ("joinChatSlot()"));
   end Create_Actions;

   ------------------------
   --  Create_Main_Menu  --
   ------------------------
   procedure Create_Main_Menu (Self : not null access Main_Window'Class) is
      Sep : Qt4.Actions.Q_Action_Access;
      pragma Warnings (Off, Sep);

   begin
      Self.Main_Menu :=
        Qt4.Menus.Q_Menu_Access
         (Self.Menu_Bar.Add_Menu (Qt4.Strings.From_Ucs_4 ("&Menu")));

      Self.Main_Menu.Add_Action (Self.Join_Chat_Act);

      Sep := Qt4.Actions.Q_Action_Access (Self.Main_Menu.Add_Separator);
      Self.Main_Menu.Add_Action (Self.Add_Group_Act);
      Self.Main_Menu.Add_Action (Self.Add_User_Act);
      Self.Main_Menu.Add_Action (Self.Find_Contact_Act);
      Sep := Qt4.Actions.Q_Action_Access (Self.Main_Menu.Add_Separator);
      Self.Main_Menu.Add_Action (Self.User_Info_Act);

      Sep := Qt4.Actions.Q_Action_Access (Self.Main_Menu.Add_Separator);
      Self.Main_Menu.Add_Action (Self.Settings_Act);

      Sep := Qt4.Actions.Q_Action_Access (Self.Main_Menu.Add_Separator);
      Self.Main_Menu.Add_Action (Self.Hide_Window_Act);
      Self.Main_Menu.Add_Action (Self.Quit_Act);
   end Create_Main_Menu;

   ------------------------
   --  Find_Contact_Act  --
   ------------------------

   procedure Find_Contact_Slot (Self  : not null access Main_Window) is
      --  use type UIM.UI.Search_Windows.Search_Window_Access;

   begin
      --  if Self.Find_Contact_Window = null then
      --     Self.Find_Contact_Window := UIM.UI.Search_Windows.Create;
      --  end if;

      --  Self.Find_Contact_Window.Show;
      null;
   end Find_Contact_Slot;

   ----------------------
   --  Join_Chat_Slot  --
   ----------------------

   procedure Join_Chat_Slot (Self  : not null access Main_Window) is
      --  W  : constant not null access UIM.UI.Main_Widgets.Main_Widget'Class
      --    := UIM.UI.Main_Widgets.Main_Widget'Class
      --        (Self.Cent_Widget.Current_Widget.all)'Access;

      --  Enter_Chat_Dialog :
      --    constant UIM.UI.Enter_Chat_Dialogs.Enter_Chat_Dialog_Access
      --      := UIM.UI.Enter_Chat_Dialogs.Create (W.Get_Proto);

   begin
      --  Enter_Chat_Dialog.Show;
      null;
   end Join_Chat_Slot;

   --------------------------
   --  Load_Settings_Slot  --
   --------------------------

   procedure Load_Settings_Slot (Self  : not null access Main_Window) is
   begin
      --  Self.Params.Get_Window_Params (Self);
      null;
   end Load_Settings_Slot;

   --------------------------
   --  Save_Settings_Slot  --
   --------------------------

   procedure Save_Settings_Slot (Self  : not null access Main_Window) is
   begin
      null;
      --  Self.Params.Save_Window_Params (Self);
   end Save_Settings_Slot;

   --------------------------
   --  Show_Settings_Slot  --
   --------------------------

   procedure Show_Settings_Slot (Self : not null access Main_Window) is
      --  use type UIM.UI.Settings_Windows.Settings_Window_Access;

   begin
      --  if Self.Settings = null then
      --     Self.Settings :=
      --       UIM.UI.Settings_Windows.Settings_Window_Access
      --         (UIM.UI.Settings_Windows.Create);
      --  end if;

      --  Self.Settings.Show;
      null;
   end Show_Settings_Slot;

   ----------------------
   --  Show_User_Info  --
   ----------------------

   procedure Show_User_Info (Self  : not null access Main_Window) is
      --  W  : constant not null access UIM.UI.Main_Widgets.Main_Widget'Class
      --    := UIM.UI.Main_Widgets.Main_Widget'Class
      --    (Self.Cent_Widget.Current_Widget.all)'Access;

   begin
      null;
      --  W.Show_User_Info_Slot;
   end Show_User_Info;

end UIM.UI.Main_Windows;
