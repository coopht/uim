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
with Ada.Characters.Conversions;
with Ada.Text_IO;

with League.Strings;

with Qt4.Combo_Boxes.Constructors;
with Qt4.H_Box_Layouts.Constructors;
with Qt4.Objects;
with Qt4.Strings;
with Qt4.Tool_Buttons.Constructors;
with Qt4.Tree_Views.Constructors;
with Qt4.V_Box_Layouts.Constructors;

with System.Address_To_Access_Conversions;

with UIM.UI.Proto_Widgets.MOC;
pragma Warnings (Off, UIM.UI.Proto_Widgets.MOC);
--  Child package MOC must be included in the executable file.

with UIM.Protocols.Contact_List_Items;
with UIM.Protocols.Messages;
--  with UIM.Protocols.Statuses.Lists;
--  with UIM.Protocols.Users;

--  with UIM.UI.User_Info_Windows;

--  with UIM.UI.UXMPP.Services;

package body UIM.UI.Proto_Widgets is

   use type Qt4.Q_Integer;
   --  use type UIM.UI.Chat_Windows.Chat_Window_Access;
   use UIM.Protocols.Contact_List_Items;

   package Convert is
      new System.Address_To_Access_Conversions
       (UIM.Protocols.Contact_List_Items.Contact_List_Item);

   ---------------
   --  Create   --
   ---------------
   function Create
    (Proto : not null access UIM.Protocols.Common.Common_Protocol'Class)
      return not null Proto_Widget_Access
   is
      Self : constant not null Proto_Widget_Access := new Proto_Widget;

      V_Layout :
        constant not null access Qt4.V_Box_Layouts.Q_V_Box_Layout'Class
          := Qt4.V_Box_Layouts.Constructors.Create;

      H_Layout :
        constant not null access Qt4.H_Box_Layouts.Q_H_Box_Layout'Class
          := Qt4.H_Box_Layouts.Constructors.Create;

   begin
      Qt4.Widgets.Directors.Constructors.Initialize (Self);
      Self.Contact_List := Qt4.Tree_Views.Constructors.Create;
      Self.Proto := Proto;

      --  XXX: Not yet implemented in QtAda
      --  Self.Contact_List.Header.Set_Visible (false);

      Self.Status_Box := Qt4.Combo_Boxes.Constructors.Create;
      Self.Menu_Button := Qt4.Tool_Buttons.Constructors.Create;

      --  XXX not yet implemented in QtAda
      --  Self.Status_Box.Add_Items (Self.Proto.Get_List_Of_Statuses);
      --  Self.Contact_List.Set_Model (Self.Proto.Get_Contact_List.Get_Model);

      for J in 0 .. Self.Proto.Get_Status_List.Size - 1 loop
         Self.Status_Box.Add_Item
           (Qt4.Strings.From_Ucs_4
             (Self.Proto.Get_Status_List.Value (J).Name.To_Wide_Wide_String));
      end loop;

      Self.Status_Box.Set_Current_Index
       (Qt4.Q_Integer (Self.Proto.Get_Status_List.Size - 1));

      H_Layout.Add_Widget (Self.Status_Box);
      H_Layout.Add_Widget (Self.Menu_Button);

      V_Layout.Add_Widget (Self.Contact_List);
      V_Layout.Add_Layout (H_Layout);

      Self.Set_Layout (V_Layout);

      Qt4.Objects.Connect
       (Self.Proto.Get_Protocol_Handler,
        Qt4.Signal ("messageRecieveSignal(QVariant)"),
        Self,
        Qt4.Slot ("newMsgSlot(QVariant)"));

      --  Qt4.Objects.Connect
      --   (Self.Proto.Get_Protocol_Handler,
      --    Qt4.Signal ("typingNotificationSignal(QVariant)"),
      --    Self,
      --    Qt4.Slot ("typingMessageSlot(QVariant)"));

      Qt4.Objects.Connect
       (Self.Status_Box,
        Qt4.Signal ("activated(int)"),
        Self,
        Qt4.Slot ("statusBoxActivated(int)"));

      Qt4.Objects.Connect
       (Self.Contact_List,
        Qt4.Signal ("activated(QModelIndex)"),
        Self,
        Qt4.Slot ("clItemActivated(QModelIndex)"));

      --  Qt4.Objects.Connect
      --   (Self.Contact_List,
      --    Qt4.Signal ("customContextMenuRequested (QPoint)"),
      --    Self,
      --    Qt4.Slot ("CLContextMenuSlot()"));

      Qt4.Objects.Connect
       (Self.Menu_Button,
        Qt4.Signal ("clicked()"),
        Self,
        Qt4.Slot ("menuButtonSlot()"));

      return Self;
   end Create;

   --------------------
   --  New_Msg_Slot  --
   --------------------
   --  This slot implements chat window dialog behavior,
   --  when new message arrives.
   procedure  New_Msg_Slot (Self : not null access Proto_Widget;
                            Msg  : Qt4.Variants.Q_Variant) is
      --  M : constant not null UIM.Protocols.Messages.Message_Access
      --    := UIM.Protocols.Messages.Message_Variant.To_Value (Msg);

   begin
      null;
      --  Ada.Text_IO.Put_Line ("Slot From :" &
      --                          M.Get_From.Get_Info.Get_Nick_Name.To_Utf_8);
      --  Ada.Text_IO.Put_Line ("Slot Text :" & M.all.Get_Plain_Text.To_Utf_8);
      --  If chat window is not loaded we should load it from ui file
      --  if Self.Chat_Window = null then
      --     Self.Chat_Window := UIM.UI.Chat_Windows.Create (Self);
      --  end if;

      --  Self.Chat_Window.Add_Dialog (M.Get_From, M);
   end New_Msg_Slot;

   ----------------------------
   --  Status_Box_Activated  --
   ----------------------------
   procedure Status_Box_Activated (Self  : not null access Proto_Widget;
                                   Index : Qt4.Q_Integer) is
   begin
      Self.Proto.Change_Status
        (League.Strings.To_Universal_String
           (Ada.Characters.Conversions.To_Wide_Wide_String
              (Self.Status_Box.Item_Text (Index).To_Utf_16)));
   end Status_Box_Activated;

   -------------------------
   --  CL_Item_Activated  --
   -------------------------
   procedure CL_Item_Activated (Self  : not null access Proto_Widget;
                                Index : Qt4.Model_Indices.Q_Model_Index)
   is
      pragma Warnings (Off, Self);
      pragma Warnings (Off, Index);
      --  Abstr_Item : UIM.Protocols.List_Items.List_Item_Access;
      --  Item       : UIM.Protocols.Users.User_Access;

   begin
      null;
      --  if Index.Is_Valid then
      --     Abstr_Item :=
      --       UIM.Protocols.List_Items.List_Item_Access
      --       (Convert.To_Pointer (Index.Internal_Pointer));

      --     if Abstr_Item.Get_Item_Type = User_Item then
      --        Item := UIM.Protocols.Users.User_Access (Abstr_Item);

      --        --  if Self.Chat_Window = null then
      --        --     Self.Chat_Window := UIM.UI.Chat_Windows.Create (Self);
      --        --  end if;

      --        --  Self.Chat_Window.Add_Dialog (Item);
      --     end if;
      --  end if;
   end CL_Item_Activated;

   ---------------------------
   --  Typing_Message_Slot  --
   ---------------------------
   procedure Typing_Message_Slot (Self : not null access Proto_Widget;
                                  User : Qt4.Variants.Q_Variant) is
      --  U : constant not null UIM.Protocols.Users.User_Access
      --    := UIM.Protocols.Users.User_Variant.To_Value (User);
      --  pragma Unreferenced (Self);

   begin
      --  Ada.Text_IO.Put_Line ("User : " &
      --                          U.Get_Info.Get_Nick_Name &
      --                          " is typing a message");
      null;
   end Typing_Message_Slot;

   ----------------------
   --  Show_User_Info  --
   ----------------------
   procedure Show_User_Info_Slot (Self  : not null access Proto_Widget) is
      --  Index       : constant Qt4.Model_Indices.Q_Model_Index
      --    := Self.Contact_List.Current_Index;

      --  Item        : UIM.Protocols.Users.User_Access;
      --  Abstr_Item  : UIM.Protocols.List_Items.List_Item_Access;
      --  Info_Window : UIM.UI.User_Info_Windows.User_Info_Window_Access;

   begin
      --  if Index.Is_Valid then
      --     Abstr_Item :=
      --       UIM.Protocols.List_Items.List_Item_Access
      --       (Convert.To_Pointer (Index.Internal_Pointer));

      --     if Abstr_Item.Get_Item_Type = User_Item then
      --        Item := UIM.Protocols.Users.User_Access (Abstr_Item);

      --        Info_Window := UIM.UI.User_Info_Windows.Create (Self, Item);

      --        Qt4.Objects.Connect
      --         (Self.Proto.Get_Protocol_Handler,
      --          Qt4.Signal ("userInfoRecivedSignal(QVariant)"),
      --          Info_Window,
      --          Qt4.Slot ("userInfoSlot(QVariant)"));

      --        Info_Window.Show;
      --     end if;
      --  else
      --     Info_Window := UIM.UI.User_Info_Windows.Create (Self);
      --     Info_Window.Show;
      --  end if;
      null;
   end Show_User_Info_Slot;

   ----------------------------
   --  CL_Context_Menu_Slot  --
   ----------------------------
   procedure CL_Context_Menu_Slot (Self : not null access Proto_Widget) is
      pragma Unreferenced (Self);
   begin
      Ada.Text_IO.Put_Line ("CL_Context_Menu_Slot");
   end CL_Context_Menu_Slot;

   -----------------
   --  Get_Proto  --
   -----------------
   function Get_Proto (Self : not null access Proto_Widget)
      return not null access UIM.Protocols.Common.Common_Protocol'Class is
   begin
      return Self.Proto;
   end Get_Proto;

   procedure Menu_Button_Slot (Self : not null access Proto_Widget) is
      --  S : constant UIM.UI.UXMPP.Services.Services_Widget_Access
      --    := UIM.UI.UXMPP.Services.Create (Self.Proto);

      pragma Unreferenced (Self);

   begin
      --  S.Show;
      null;
   end Menu_Button_Slot;

end UIM.UI.Proto_Widgets;
