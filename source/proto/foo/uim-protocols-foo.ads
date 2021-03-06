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

with UIM.Protocols.Contact_Lists;
with UIM.Protocols.Common;
with UIM.Protocols.Handlers;
with UIM.Protocols.Messages;
with UIM.Protocols.Statuses;
with UIM.Utils.Logger;

package UIM.Protocols.Foo is

   type UIM_Foo is limited new UIM.Protocols.Common.Common_Protocol with
   record
      Name    : League.Strings.Universal_String
        := League.Strings.To_Universal_String ("foo");
      Id      : Positive;
      Handler : UIM.Protocols.Handlers.Protocol_Handler_Access
        := UIM.Protocols.Handlers.Create;
      Logger  : UIM.Utils.Logger.UIM_Logger;
      St      : UIM.Protocols.Statuses.Status_List;
   end record;

   type UIM_Foo_Access is access all UIM_Foo;

   overriding procedure Set_Status
    (Self   : not null access UIM_Foo;
     Status : UIM.Protocols.Statuses.Status) is null;

   overriding function Get_Status_List (Self : not null access UIM_Foo)
      return UIM.Protocols.Statuses.Status_List;

   overriding procedure Change_Status
    (Self   : not null access UIM_Foo;
     Status : League.Strings.Universal_String) is null;

   overriding function Get_Protocol_Handler
    (Self : not null access UIM_Foo)
      return not null UIM.Protocols.Handlers.Protocol_Handler_Access;

   overriding function Get_Name (Self : not null access UIM_Foo)
      return League.Strings.Universal_String;

   overriding function Get_Id (Self : not null access UIM_Foo)
      return Positive;

   overriding procedure Set_Id (Self : not null access UIM_Foo;
                                Id   : Positive);

   overriding function Get_Contact_List (Self : not null access UIM_Foo)
      return UIM.Protocols.Contact_Lists.Contact_List_Access;

   overriding  procedure Send_Message
     (Self : not null access UIM_Foo;
      Msg  : not null UIM.Protocols.Messages.Message_Access);

end UIM.Protocols.Foo;
