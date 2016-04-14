/*
 *     Copyright 2016 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */
 
import Foundation
import BluemixObjectStore

class Tester{
	let projectId = ""
	let userId = ""
	let password = ""
	let containerName = "FileContainer"
	let objectName = "hello.txt"
	let region = ObjectStore.REGION_DALLAS

	func run(){
		let objStore = ObjectStore(projectId: projectId)
		objStore.connect(userId: userId, password: password, region: region) { (error) in
			if let error = error {
				print("connect failure \(error)")
			} else {
				print("connect success")
				self.getContainer(objStore: objStore)
			}
		}
	}

	func getContainer(objStore:ObjectStore){
		objStore.retrieveContainer(name: containerName, completionHandler: { (error, container) in
			if let error = error {
				print("retrieveContainer failure \(error)")
			} else {
				print("retrieveContainer success")
				self.getObject(objContainer: container!)
			}
		})

	}

	func getObject(objContainer:ObjectStoreContainer){
		objContainer.retrieveObject(name: objectName) { (error, object) in
			if let error = error {
				print("getObject failure \(error)")
			} else {
				print("getObject success")
				self.load(object: object!)
			}
		}
	}

	func load(object:ObjectStoreObject){
		object.load(shouldCache: false) { (error, data) in
			if let error = error {
				print("loadObject failure \(error)")
			} else {
				print("loadObject success \(data)")
			}
		}
	}
}

Tester().run();

#if swift(>=3)
	NSRunLoop.current().run()
#else
	NSRunLoop.currentRunLoop().run()
#endif
