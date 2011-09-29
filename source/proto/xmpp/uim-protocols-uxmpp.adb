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
with Qt4.Strings;

with UIM.Protocols.Informations;
with UIM.Protocols.Users;

with XMPP.Logger;
package body UIM.Protocols.UXMPP is

   use type League.Strings.Universal_String;
   use type XMPP.Messages.Message_Type;

   function "+" (Item : Wide_Wide_String)
     return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function To_Canonical_JID (JID : Wide_Wide_String) return Wide_Wide_String;

   ---------------------------
   --  Bind_Resource_State  --
   ---------------------------
   overriding procedure Bind_Resource_State
     (Self   : in out UIM_XMPP;
      JID    : League.Strings.Universal_String;
      Status : XMPP.Bind_State)
   is
      use type XMPP.Bind_State;

   begin
      if Status = XMPP.Success then
         Self.Logger.Log
          ("Resource Binded Success: " & JID.To_Wide_Wide_String);

         --  After resource binded successfull establishing session
         Self.Establish_IQ_Session;
      end if;

   end Bind_Resource_State;

   ---------------------
   --  Change_Status  --
   ---------------------

   overriding procedure Change_Status
    (Self   : not null access UIM_XMPP;
     Status : League.Strings.Universal_String) is
   begin
      if Status = League.Strings.To_Universal_String ("Online") then
         Self.Logger.Log ("Connecting");
         --  Self.Set_JID (League.Strings.To_Universal_String
         --    (Params.Get_Login.To_Ucs_4));

         --  For local testing

         Self.Set_JID
           (League.Strings.To_Universal_String ("uim-test@zion"));

         --  Self.Set_Password (League.Strings.To_Universal_String
         --      (Params.Get_Password.To_Ucs_4));

         Self.Set_Password
           (League.Strings.To_Universal_String ("123"));

         --  for jabber.ru testing
         --  Self.Set_Password
         --    (League.Strings.To_Universal_String ("123456"));

         Self.Set_Stream_Handler (Self);
         Self.Open;
      end if;
   end Change_Status;

   -----------------
   --  Connected  --
   -----------------
   overriding procedure Connected
     (Self   : in out UIM_XMPP;
      Object : XMPP.Stream_Features.XMPP_Stream_Feature'Class) is
      pragma Unreferenced (Object);

   begin
      Self.Logger.Log ("Yeah We are connected, binding resource");
      Self.Bind_Resource (League.Strings.To_Universal_String ("uim-ada"));
   end Connected;

   --------------
   --  Create  --
   --------------
   function Create return not null UIM_XMPP_Access is
      Self : constant not null UIM_XMPP_Access := new UIM_XMPP;

   begin
      XMPP.Logger.Enable_Debug;
      Self.CL := new UIM.Protocols.Contact_Lists.Contact_List;

      Self.St.Append (+"Online", 0);
      Self.St.Append (+"Offline", 1);

      return Self;
   end Create;

   ------------------------
   --  Get_Contact_List  --
   ------------------------

   overriding function Get_Contact_List (Self : not null access UIM_XMPP)
      return UIM.Protocols.Contact_Lists.Contact_List_Access is
   begin
      return Self.CL;
   end Get_Contact_List;

   --------------
   --  Get_Id  --
   --------------

   overriding function Get_Id (Self : not null access UIM_XMPP)
      return Positive is
   begin
      return Self.Id;
   end Get_Id;

   ----------------
   --  Get_Name  --
   ----------------
   overriding function Get_Name (Self : not null access UIM_XMPP)
      return League.Strings.Universal_String is
   begin
      return Self.Name;
   end Get_Name;

   ----------------------------
   --  Get_Protocol_Handler  --
   ----------------------------

   overriding function Get_Protocol_Handler
    (Self : not null access UIM_XMPP)
      return not null UIM.Protocols.Handlers.Protocol_Handler_Access is
   begin
      return Self.Handler;
   end Get_Protocol_Handler;

   -----------------------
   --  Get_Status_List  --
   -----------------------

   overriding function Get_Status_List (Self : not null access UIM_XMPP)
      return UIM.Protocols.Statuses.Status_List is
   begin
      return Self.St;
   end Get_Status_List;

   ---------------
   --  Message  --
   ---------------
   overriding procedure Message
     (Self : in out UIM_XMPP;
      Msg  : XMPP.Messages.XMPP_Message'Class) is

      --  Target_Msg : constant not null UIM.Protocols.Messages.Message_Access
      --    := new UIM.Protocols.Messages.Message;

      --  --  XXX: User, User_Info shoud not to be created here

      --  User       : constant UIM.Protocols.Users.User_Access
      --    := new UIM.Protocols.Users.User (Self.Proto_Id);

      --  User_Info  : constant not null
      --  UIM.Protocols.User_Infos.User_Info_Access
      --    := new UIM.Protocols.User_Infos.User_Info;

      --  Buddy_State : UIM.Protocols.Messages.UIM_State_Type;

   begin
      Self.Logger.Log ("Message received from :"
                    & Msg.Get_From.To_Wide_Wide_String);

      --  Target_Msg.Set_Plain_Text (Msg.Get_Body.To_Wide_Wide_String);

      --  User_Info.Set_ID
      --   (Qt4.Strings.From_Ucs_4
      --     (To_Canonical_JID (Msg.Get_From.To_Wide_Wide_String)));
      --  User.Set_Info (User_Info);
      --  Target_Msg.Set_From (User);

      --  case Msg.Get_Chat_State is

      --     when XMPP.Messages.Active =>
      --        Buddy_State := UIM.Protocols.Messages.Active;

      --     when XMPP.Messages.Composing =>
      --        Buddy_State := UIM.Protocols.Messages.Composing;

      --     when XMPP.Messages.Paused =>
      --        Buddy_State := UIM.Protocols.Messages.Paused;

      --     when XMPP.Messages.Inactive =>
      --        Buddy_State := UIM.Protocols.Messages.Inactive;

      --     when XMPP.Messages.Gone =>
      --        Buddy_State := UIM.Protocols.Messages.Gone;
      --  end case;

      --  Target_Msg.Set_State (Buddy_State);

      --  Self.D.Log ("From: " & Msg.Get_From);
      --  Self.D.Log ("Body: " & Msg.Get_Body);

      --  if Msg.Get_Type = XMPP.Messages.Group_Chat then
      --     Target_Msg.Type_Of_Msg := UIM.Protocols.Messages.Conference;
      --  end if;

      --  Self.Glue.Message_Recieve_Signal (Target_Msg);

   end Message;

   ----------------
   --  Presence  --
   ----------------
   overriding procedure Presence
     (Self : in out UIM_XMPP;
      Data : XMPP.Presences.XMPP_Presence'Class) is
   begin
      Self.Logger.Log
        ("User "
           & Data.Get_From.To_Wide_Wide_String
           & " is "
           & XMPP.Presences.Show_Kind'Wide_Wide_Image (Data.Get_Show)
           & "(" & Data.Get_Status.To_Wide_Wide_String & ")");

      --  Requesting sirvice discovery information : for debugging
      --  Self.Discover_Information
      --   (League.Strings.To_Universal_String ("conference.zion"));

      --  Self.Discover_Items
      --   (League.Strings.To_Universal_String ("conference.zion"));

      --  Self.Discover_Information
      --   (League.Strings.To_Universal_String ("conf@conference.zion"));

      --  Self.Discover_Items
      --   (League.Strings.To_Universal_String ("conf@conference.zion"));

      --  Self.Discover_Items
      --   (League.Strings.To_Universal_String ("conf@conference.zion/test"));
      --  Self.Request_Version
      --    (League.Strings.To_Universal_String ("zion"));
   end Presence;

   --------------
   --  Roster  --
   --------------
   overriding procedure Roster
     (Self : in out UIM_XMPP;
      Data : XMPP.Rosters.XMPP_Roster'Class) is
      P    : XMPP.Presences.XMPP_Presence;

   begin
      Self.Logger.Log (" >>>>>>>>>>>>>>>>>>>> Roster Arrived");
      Self.Logger.Log ("Proto ID = " & Natural'Wide_Wide_Image (Self.Id));

      for J in 0 .. Data.Items_Count - 1 loop
         declare
            User : constant UIM.Protocols.Users.User_Access
              := new UIM.Protocols.Users.User (Self.Id);

            Info : UIM.Protocols.Informations.Information;

         begin
            Self.Logger.Log
              ("Adding user : "
                 & Data.Item_At (J).Get_JID.To_Wide_Wide_String);

            Info.Set_Id
             (Qt4.Strings.From_Ucs_4
               (Data.Item_At (J).Get_JID.To_Wide_Wide_String));

            User.Set_Name
              (Qt4.Strings.From_Ucs_4
                 (Data.Item_At (J).Get_JID.To_Wide_Wide_String));

            User.Set_Information (Info);
            Self.CL.Add_User (User);
         end;
      end loop;

      --  Sending Presence roster
      Self.Send_Object (P);
   end Roster;

   ---------------------------
   --  Service_Information  --
   ---------------------------

   overriding procedure Service_Information
    (Self : in out UIM_XMPP;
     Info : XMPP.Services.XMPP_Service'Class) is
      pragma Warnings (Off, Self);
      pragma Warnings (Off, Info);
   begin
      --  Self.Handler.Service_Information_Signal
      --    (XMPP.Services.XMPP_Service (Info));
      null;
   end Service_Information;

   ---------------------
   --  Session_State  --
   ---------------------
   overriding procedure Session_State
     (Self   : in out UIM_XMPP;
      Status : XMPP.IQ_Sessions.Session_State) is
      use type XMPP.IQ_Sessions.Session_State;

   begin
      if Status = XMPP.IQ_Sessions.Established then
         Self.Logger.Log ("Session established !!!");

         --  After session successfully established

         --  Requesting roster
         Self.Request_Roster;
      end if;
   end Session_State;

   --------------
   --  Set_Id  --
   --------------
   overriding procedure Set_Id (Self : not null access UIM_XMPP; Id : Positive)
   is
   begin
      Self.Id := Id;
   end Set_Id;

   ------------------------
   --  To_Canonical_JID  --
   ------------------------

   function To_Canonical_JID (JID : Wide_Wide_String) return Wide_Wide_String
   is
   begin
      return League.Strings.To_Universal_String
              (JID).Split ('/').Element (1).To_Wide_Wide_String;
   end To_Canonical_JID;

   ---------------
   --  Version  --
   ---------------
   overriding procedure Version
     (Self    : in out UIM_XMPP;
      Version : XMPP.Versions.XMPP_Version'Class) is
   begin
      Self.Logger.Log ("=== Version ===");
      Self.Logger.Log ("Name    : " & Version.Get_Name);
      Self.Logger.Log ("OS      : " & Version.Get_OS);
      Self.Logger.Log ("Version : " & Version.Get_Version);
   end Version;

   -----------------------
   --  Version_Request  --
   -----------------------

   overriding procedure Version_Request
     (Self    : in out UIM_XMPP;
      Version : in out XMPP.Versions.XMPP_Version'Class) is
      Ver : XMPP.Versions.XMPP_Version;

   begin
      Self.Logger.Log ("Version_Requested");
      Ver.Set_IQ_Kind (XMPP.Result);
      Ver.Set_To (Version.Get_From);
      Ver.Set_Name (+"uim");
      Ver.Set_OS (+"Linux");
      Ver.Set_Version (+"1.2.3");
      Self.Send_Object (Ver);
   end Version_Request;

end UIM.Protocols.UXMPP;
