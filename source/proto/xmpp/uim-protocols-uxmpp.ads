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
with League.Strings;

with UIM.Protocols.Common;
with UIM.Protocols.Contact_Lists;
with UIM.Protocols.Handlers;
with UIM.Protocols.Messages;
with UIM.Protocols.Statuses;

with UIM.Utils.Logger;

with XMPP.Binds;
with XMPP.IQ_Sessions;
with XMPP.Presences;
with XMPP.Rosters;
with XMPP.Sessions;
with XMPP.Services;
with XMPP.Stream_Handlers;
with XMPP.Stream_Features;
with XMPP.Messages;
with XMPP.Versions;

package UIM.Protocols.UXMPP is

   type UIM_XMPP is limited new XMPP.Sessions.XMPP_Session
     and UIM.Protocols.Common.Common_Protocol
     and XMPP.Stream_Handlers.XMPP_Stream_Handler with
   record
      Name    : League.Strings.Universal_String
        := League.Strings.To_Universal_String ("xmpp");
      Id      : Positive;
      Handler : UIM.Protocols.Handlers.Protocol_Handler_Access
        := UIM.Protocols.Handlers.Create;
      Logger  : UIM.Utils.Logger.UIM_Logger;
      St      :  UIM.Protocols.Statuses.Status_List;
      CL      : UIM.Protocols.Contact_Lists.Contact_List_Access;
   end record;

   type UIM_XMPP_Access is access all UIM_XMPP'Class;

   function Create return not null UIM_XMPP_Access;

   --  Common protocols overriden routines

   overriding
   procedure Send_Message
     (Self : not null access UIM_XMPP;
      Msg  : not null UIM.Protocols.Messages.Message_Access);

   overriding procedure Set_Status
    (Self   : not null access UIM_XMPP;
     Status : UIM.Protocols.Statuses.Status) is null;

   overriding function Get_Status_List (Self : not null access UIM_XMPP)
      return UIM.Protocols.Statuses.Status_List;

   overriding function Get_Contact_List (Self : not null access UIM_XMPP)
      return UIM.Protocols.Contact_Lists.Contact_List_Access;

   overriding procedure Change_Status
    (Self   : not null access UIM_XMPP;
     Status : League.Strings.Universal_String);

   overriding function Get_Protocol_Handler
    (Self : not null access UIM_XMPP)
      return not null UIM.Protocols.Handlers.Protocol_Handler_Access;

   overriding function Get_Name (Self : not null access UIM_XMPP)
      return League.Strings.Universal_String;

   overriding function Get_Id (Self : not null access UIM_XMPP)
      return Positive;

   overriding procedure Set_Id (Self : not null access UIM_XMPP;
                                Id   : Positive);

   --  XMPP Stream Handlers

   overriding procedure Connected
     (Self   : in out UIM_XMPP;
      Object : XMPP.Stream_Features.XMPP_Stream_Feature'Class);

   overriding procedure Bind_Resource_State
     (Self   : in out UIM_XMPP;
      JID    : League.Strings.Universal_String;
      Status : XMPP.Bind_State);

   overriding procedure Session_State
     (Self   : in out UIM_XMPP;
      Status : XMPP.IQ_Sessions.Session_State);

   overriding procedure Service_Information
    (Self : in out UIM_XMPP;
     Info : XMPP.Services.XMPP_Service'Class);

   overriding procedure Presence
     (Self : in out UIM_XMPP;
      Data : XMPP.Presences.XMPP_Presence'Class);

   overriding procedure Roster
     (Self : in out UIM_XMPP;
      Data : XMPP.Rosters.XMPP_Roster'Class);

   overriding procedure Message
     (Self : in out UIM_XMPP;
      Msg  : XMPP.Messages.XMPP_Message'Class);

   overriding procedure Version
     (Self    : in out UIM_XMPP;
      Version : XMPP.Versions.XMPP_Version'Class);

   overriding procedure Version_Request
     (Self    : in out UIM_XMPP;
      Version : in out XMPP.Versions.XMPP_Version'Class);

end UIM.Protocols.UXMPP;
