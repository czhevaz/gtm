package com.smanggin.trackingmanagement

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.List;

import org.usb4java.Context;
import org.usb4java.Device;
import org.usb4java.DeviceDescriptor;
import org.usb4java.DeviceList;
import org.usb4java.LibUsb;
import org.usb4java.LibUsbException;
import org.usb4java.BufferUtils;
import org.usb4java.DeviceHandle;
import java.nio.IntBuffer

import jssc.SerialPortList;

/**
 * ListDeviceController
 * A controller class handles incoming web requests and performs actions such as redirects, rendering views and so on.
 */
class ListDeviceController {
	 private static final short VENDOR_ID = 0x0C2E;
	private static final byte _USB_TYPE_CLASS         = (0x01 << 5);
    private static final byte _USB_RECIP_INTERFACE    = 0x00;
    private static final byte _USB_ENDPOINT_IN        = (byte)0x80;
    private static final byte _USB_ENDPOINT_OUT       = 0x00;

    private static final byte _HID_GET_REPORT         = 0x01;
    private static final byte _HID_SET_REPORT         = 0x09;

    private static final int _USB_TIMEOUT_MS         = 2000;

    // from ykcore_backend.h
    private static final byte _FEATURE_RPT_SIZE       = 8;
    private static final short _REPORT_TYPE_FEATURE    = 0x03;    

	def index(){
		// Create the libusb context
        Context context = new Context();

        // Initialize the libusb context
        int result = LibUsb.init(context);
        if (result < 0)
        {
            throw new LibUsbException("Unable to initialize libusb", result);
        }

        // Read the USB device list
        DeviceList list = new DeviceList();
        result = LibUsb.getDeviceList(context, list);
        if (result < 0)
        {
            throw new LibUsbException("Unable to get device list", result);
        }

         try
        {
            // Iterate over all devices and list them
            for (Device device: list)
            {
                int address = LibUsb.getDeviceAddress(device);
                int busNumber = LibUsb.getBusNumber(device);
                DeviceDescriptor descriptor = new DeviceDescriptor();
                result = LibUsb.getDeviceDescriptor(device, descriptor);
                if (result < 0)
                {
                    throw new LibUsbException(
                        "Unable to read device descriptor", result);
                }else{
                	println "descriptor.idVendor()" + descriptor.idVendor()
                	if (descriptor.idVendor() == VENDOR_ID ) {
	                    println "descriptor.idVendor() true " + descriptor.idVendor()
				        DeviceHandle handle = new DeviceHandle();
				        result = LibUsb.open(device, handle);
				        if (result != LibUsb.SUCCESS){
				            throw new LibUsbException("Unable to open USB device", result);
				        }

				        
				            // Check if kernel driver is attached to the interface
				            int attached = LibUsb.kernelDriverActive(handle, _USB_RECIP_INTERFACE);
				            if (attached < 0 && attached!=LibUsb.ERROR_NOT_SUPPORTED){   
				                //debug("Attach error (not supported on Windows?):"+attached);
				                throw new LibUsbException("Unable to check kernel driver active", result);
				            }

				            // Detach kernel driver from interface 0 and 1. This can fail if
				            // kernel is not attached to the device or operating system
				            // doesn't support this operation. These cases are ignored here.
				            result = LibUsb.detachKernelDriver(handle, _USB_RECIP_INTERFACE);
				            if (result != LibUsb.SUCCESS &&
				                result != LibUsb.ERROR_NOT_SUPPORTED &&
				                result != LibUsb.ERROR_NOT_FOUND)
				            {
				                throw new LibUsbException("Unable to detach kernel driver", result);
				            }
				             // Claim interface
				            result = LibUsb.claimInterface(handle, 1);
				            if (result != LibUsb.SUCCESS){
				                throw new LibUsbException("Unable to claim interface", result);
				            }
				            
				            System.out.println("claimInterface:"+result);
				            
				            ByteBuffer buffer = ByteBuffer.allocateDirect(_FEATURE_RPT_SIZE);
					        buffer.rewind();
					        int transfered = LibUsb.controlTransfer(handle,
					            (byte) (LibUsb.REQUEST_TYPE_CLASS | LibUsb.RECIPIENT_INTERFACE | _USB_ENDPOINT_IN),
					            _HID_GET_REPORT,
					            (short)(_REPORT_TYPE_FEATURE << 8),//(short) 2,
					            (short) 1, buffer, _USB_TIMEOUT_MS);
					        
					        if (transfered < 0)
					            throw new LibUsbException("Control transfer failed", transfered);
					        if (transfered != _FEATURE_RPT_SIZE)
					            throw new RuntimeException("Not all data was received from device:"+transfered);
					        
					        byte[] data= new byte[_FEATURE_RPT_SIZE];
					        buffer.rewind();
					        for (int i=0; i<_FEATURE_RPT_SIZE; i++){
					            data[i]= buffer.get();
					        }
					        //debug("Data received from device: "+YubikeyUtil.toHexString(data));
					        
						    LibUsb.releaseInterface(handle, _USB_RECIP_INTERFACE); 
						    LibUsb.close(handle); 

				            
                	}
			        
                }
                
            }
        }
        finally
        {
            // Ensure the allocated device list is freed
            LibUsb.freeDeviceList(list, true);
        }

        // Deinitialize the libusb context
        LibUsb.exit(context);
	}

	def serial(){
		String[] portNames = SerialPortList.getPortNames();
		println "portName" +portNames
	    for(int i = 0; i < portNames.length; i++){
	        System.out.println(portNames[i]);
	    }
	}

	
}
