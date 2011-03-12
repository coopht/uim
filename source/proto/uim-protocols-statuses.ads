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
with Ada.Containers.Vectors;

with League.Strings;

package UIM.Protocols.Statuses is

   type Status is tagged private;

   function Id (Self : Status) return Integer;
   --  returns Status ID

   procedure Set_Id (Self : in out Status; Id : Integer);
   --  sets status ID

   function Name (Self : Status) return League.Strings.Universal_String;
   --  returns status name

   procedure Set_Name
     (Self : in out Status;
      Name : League.Strings.Universal_String);
   --  sets status name

   function State (Self : Status) return League.Strings.Universal_String;
   --  returns status state state

   procedure Set_State (Self : in out Status;
                        Name : League.Strings.Universal_String);
   --  sets status state

   type Status_List is tagged private;

   procedure Append (Self : in out Status_List; Val : Status'Class);

   procedure Append (Self        : in out Status_List;
                     Status_Name :        League.Strings.Universal_String;
                     Id          :        Natural);

   function Size (Self : Status_List) return Natural;

   function Value (Self : Status_List; Pos : Natural) return Status'Class;

private

   type Status is tagged record
     Status_Name : League.Strings.Universal_String;
     State       : League.Strings.Universal_String;
     Status_Id   : Natural;
     --  XXX should be special type for ID
   end record;

   package Status_Items is
      new Ada.Containers.Vectors (Natural, Status);

   type Status_List is tagged record
      Items : Status_Items.Vector;
   end record;

end UIM.Protocols.Statuses;
