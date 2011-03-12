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

with UIM.Protocols.Handlers;
with UIM.Protocols.Statuses;

package UIM.Protocols.Common is

   --  Each protocol, which implements current interface MUST be registered
   --  in the special protocols registry.

   type Common_Protocol is limited interface;

   type Common_Protocol_Access is access all Common_Protocol'Class;

   not overriding procedure Set_Status
    (Self   : not null access Common_Protocol;
     Status : UIM.Protocols.Statuses.Status) is abstract;

   not overriding procedure Change_Status
    (Self   : not null access Common_Protocol;
     Status : League.Strings.Universal_String) is abstract;
   --  XXX: Rewrite with appropriate types

   not overriding function Get_Status_List
    (Self : not null access Common_Protocol)
       return UIM.Protocols.Statuses.Status_List is abstract;

   not overriding function Get_Protocol_Handler
    (Self : not null access Common_Protocol)
      return not null UIM.Protocols.Handlers.Protocol_Handler_Access
        is abstract;
   --  returns events handler, associated with protocol

   not overriding function Get_Name (Self : not null access Common_Protocol)
      return League.Strings.Universal_String is abstract;
   --  returns protocol name, which can be used in application GUI

   not overriding function Get_Id (Self : not null access Common_Protocol)
      return Positive is abstract;
   --  returns protocols id,
   --  which is given to this protocol during registration

   not overriding procedure Set_Id (Self : not null access Common_Protocol;
                                    Id   : Positive) is abstract;
   --  this function is called, when protocols registry adds implementor to
   --  the list of used protocols, and sets assigned id.

end UIM.Protocols.Common;
