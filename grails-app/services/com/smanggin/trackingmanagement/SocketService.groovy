package com.smanggin.trackingmanagement

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.util.Set;
import java.net.ServerSocket


class SocketService {
	
	def port=4020
	
	
	void run() {
		runAsync {
			// Selector: multiplexor of SelectableChannel objects
			Selector selector = Selector.open(); // selector is open here
	 
			// ServerSocketChannel: selectable channel for stream-oriented listening sockets
			ServerSocketChannel socket = ServerSocketChannel.open();
			InetSocketAddress addr = new InetSocketAddress("192.168.10.222", port);
	 		println "address " + addr
			// Binds the channel's socket to a local address and configures the socket to listen for connections
			socket.bind(addr);
	 
			// Adjusts this channel's blocking mode.
			socket.configureBlocking(false);
			int ops = socket.validOps();
			SelectionKey selectKy = socket.register(selector, ops, null);

			def dataMapper = [:]

			// Infinite loop..
			// Keep server running
			while (true) {
				println "i'm a server and i'm waiting for new connection and buffer select..."
				
				// Selects a set of keys whose corresponding channels are ready for I/O operations
				selector.select();
	 			
				// token representing the registration of a SelectableChannel with a Selector
				Set<SelectionKey> crunchifyKeys = selector.selectedKeys();
				Iterator<SelectionKey> crunchifyIterator = crunchifyKeys.iterator();
				
				while (crunchifyIterator.hasNext()) {
					SelectionKey myKey = crunchifyIterator.next();

					if (!myKey.isValid()) {
						println "Not Valid Key!! " 
                    	continue;
                	}
                	String addressString = null
					if (myKey.isAcceptable()) {
						ServerSocketChannel crunchifySocket = (ServerSocketChannel) myKey.channel();
						SocketChannel crunchifyClient = crunchifySocket.accept();
						// Adjusts this channel's blocking mode to false
						crunchifyClient.configureBlocking(false);
						Socket socketClient = crunchifyClient.socket();
        				SocketAddress remoteAddr = socketClient.getRemoteSocketAddress();
	 					
						
						addressString = remoteAddr.toString()
						
						println "Connection Accepted: " + remoteAddr + "\n"
						
							def ifinlist = populateDevice().contains(splitClientAddress(addressString).ipAddress)

							if(ifinlist){
								// Operation-set bit for read operations
								crunchifyClient.register(selector, SelectionKey.OP_READ);
							}else{
								crunchifyClient.close();
							}
						
	 					
						// Tests whether this key's channel is ready for reading
					} else if (myKey.isReadable()) {
						
						SocketChannel crunchifyClient = (SocketChannel) myKey.channel();
						ByteBuffer crunchifyBuffer = ByteBuffer.allocate(256);
						crunchifyClient.read(crunchifyBuffer);
						String result = new String(crunchifyBuffer.array()).trim();
	 					
						println "Message received: " + result
						Socket socketClient = crunchifyClient.socket();
        				SocketAddress remoteAddr = socketClient.getRemoteSocketAddress();
						addressString = remoteAddr.toString()
						
	 
						if (result != null && !result.isEmpty() && !result.trim().isEmpty()) {
							println "splitClientAddress(addressString).ipAddress "	+ addressString
							ProductionInDetail.withTransaction{
								saveToProductionIn(splitClientAddress(addressString).ipAddress,result)
							}

							println "\nServer will keep running. Try running client again to establish new connection"
						}
					}
					crunchifyIterator.remove()
				}

			}//end Keep running
		}
	}


	def populateDevice(){
		def maxDevice = 2 //variable get from securyti 
		def devices = Device.createCriteria().list(){
			eq('active',true)
			maxResults(maxDevice)
		}

		return devices.ipAddress
	}

	def splitClientAddress(address){
		def split = address.split(':')
		def ipAddress =  split[0].substring(1)
		def port = split[1]
		return [ipAddress:ipAddress,port:port]
	}

	def saveToProductionIn(ipAddress,result){
		def device = Device.findByIpAddress(ipAddress)
		def gallonInstance = Gallon.findByCode(result)
		def pd = new ProductionInDetail()
		pd.transactionGroup = device.transactionGroup
    	
    	pd.number = result
    	pd.plant = device.plant
    	pd.line = device.line
    	pd.item = device.item
		pd.createdBy = 'admin'
		pd.isChecked = false
		
		if(gallonInstance){
            pd.gallon = gallonInstance
        }else{
            pd.gallon = newGallon(pd)
        }

		if(!pd.save(flush:true)){
			
			println ' errors '+pd.errors
		}
	}

	 def newGallon(pd){

        def gallonInstance = new Gallon()
        gallonInstance.code = pd.number
        gallonInstance.createdBy = 'admin'
        gallonInstance.item= pd.item
        gallonInstance.type = true
        gallonInstance.writeOff= false

        if (!gallonInstance.save(flush: true)) {
            println gallonInstance.errors
            return null
        }else{
            return gallonInstance
        }

    }

	/*void run() {
		def server = new ServerSocket(port)
		def done = false
		runAsync {
			println "Socket Service started on port: $port"
			while(true) {

			    server.accept { socket ->
			        println "processing new connection..." +socket
			        
			        socket.withStreams { input, output ->
			            def reader = input.newReader()
			            def buffer = reader.readLine()
			             
			            def block = new byte[128]
                        int size = input.read block
                        while (buffer!= null) {
                        	println "server received: $buffer"
			            	ResultScanner.withTransaction{
			            		def  iset = new ResultScanner()
			            		iset.value = buffer
			            		iset.ipAddr = socket.getRemoteSocketAddress()
			            		iset.save(flush:true)
			            			
			            	}
			            }

			        }

			        println "closed  " + socket

			        //socket.close()
			        //println socket

			        println "processing/thread complete." + socket.getRemoteSocketAddress()

			    }

			    
			}
		}
		//server.close()
	}*/
}

